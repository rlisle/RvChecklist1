//
//  ModelData.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/20/21.
//

import Foundation
import Combine
import SwiftMQTT
import UIKit

final class ModelData: ObservableObject {
    
    @Published var checklist: [ChecklistItem] = load("checklistData.json")
    
    let mqtt: MQTTManager!
    
    init(mqttManager: MQTTManager) {
        mqtt = mqttManager
        mqtt.messageHandler = { topic, message in
            //TODO:
            
        }
    }
    
    func checklist(category: String) -> [ChecklistItem] {
        return checklist.filter { $0.category == category }
    }
    
    func uncheckAll() {
        for index in 0..<checklist.count {
            checklist[index].isDone = false
        }
    }
    
    func numSelectedDone(category: String) -> Int {
        return checklist(category: category).filter { $0.isDone }.count
    }
    
    func numSelectedItems(category: String) -> Int {
        return checklist(category: category).count
    }
}

// For now we're loading from a json file.
// Later we'll want to load from iCloud or another cloud server
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

// MQTT
//TODO: Move to its own file

public enum MQTTError: Error {
    case connectionError
    case publishError
    case subscribeError
}

protocol MQTTManagerProtocol {
    var isConnected: Bool { get }
    func publish(topic: String, message: String)
}

class MQTTManager: MQTTSessionDelegate {

    let host = "localhost"
    let port: UInt16 = 1883
    let subscribeTopic = "#"
    var clientID: String = ""

    var session: MQTTSession?
    var messageHandler: ((String, String?) -> Void)?
    
    var isSubscribed = false
    
    var isConnected: Bool {
        get {
            return session != nil
        }
    }
    
    init() {
        connect()
    }
    
    private func connect() {
        clientID = getClientID()
        session = MQTTSession(host: host, port: port, clientID: clientID, cleanSession: true, keepAlive: 15, useSSL: false)
        session!.delegate = self
        session!.connect { [self] (error) in
            if error == .none {
                print("MQTT connected on clientID: \(String(describing: clientID))")
                self.subscribe()
            } else {
                print("MQTT error occurred during connection:")
                print(error.description)
            }
        }
    }

    private func subscribe() {
        session?.subscribe(to: subscribeTopic, delivering: .exactlyOnce) { (error) in
            if error == .none {
                self.isSubscribed = true
                self.requestUpdates()
            } else {
                print("MQTT subscription error:")
                print(error.description)
            }
        }
    }

    private func requestUpdates() {
        publish(topic: "patriot/getlist", message: "FrontPanel")
    }

    func publish(topic: String, message: String) {
        session?.publish(message.data(using: .utf8)!, in: topic, delivering: .atMostOnce, retain: false) { error in
            if error != .none {
                print("Error sending MQTT: \(error.description)")
            }
        }
    }
    
    func mqttDidReceive(message: MQTTMessage, from session: MQTTSession) {
        print("MQTT data received on topic \(message.topic) message \(message.stringRepresentation ?? "<>")")
        if let handler = messageHandler {
            handler(message.topic,message.stringRepresentation)
        }
    }

    func mqttDidDisconnect(session: MQTTSession, error: MQTTSessionError) {
        print("MQTT session disconnected.")
        if error != .none {
            print(error.description)
        }
        //TODO: try to reconnect
        print("MQTT Reconnecting")
        connect()
    }

    func mqttDidAcknowledgePing(from session: MQTTSession) {
//        print("MQTT deep-alive ping acknowledged.")
    }

    // MQTT non-delegate methods
    
    private func getClientID() -> String {

        let userDefaults = UserDefaults.standard
        let clientIDPersistenceKey = "clientID"
        let clientID: String

        if let savedClientID = userDefaults.object(forKey: clientIDPersistenceKey) as? String {
            clientID = savedClientID
        } else {
            clientID = randomString(length: 5)
            userDefaults.set(clientID, forKey: clientIDPersistenceKey)
            userDefaults.synchronize()
        }
        
        return clientID
    }
    
    // http://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift
    private func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}


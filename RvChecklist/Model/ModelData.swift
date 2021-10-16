//
//  ModelData.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/20/21.
//

import Foundation
import Combine
import SwiftMQTT

final class ModelData: ObservableObject {
    
    @Published var checklist: [ChecklistItem] = load("checklistData.json")
    var mqttSession: MQTTSession!
    
    init() {
        establishConnection()
    }
    
    func checklist(category: String) -> [ChecklistItem] {
        return checklist.filter { $0.category == category }
    }
    
    func syncStatus() {
        
        print("Syncing status...")
        mqttSession.publish("FrontPanel".data(using: .utf8)!, in: "patriot/getlist", delivering: .atLeastOnce, retain: false) { error in
            if error == .none {
                print("MQTT getlist sent")
            } else {
                print(error.description)
            }
        }
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

extension ModelData: MQTTSessionDelegate {

    func mqttDidReceive(message: MQTTMessage, from session: MQTTSession) {
        print("MQTT data received on topic \(message.topic) message \(message.stringRepresentation ?? "<>")")
    }

    func mqttDidDisconnect(session: MQTTSession, error: MQTTSessionError) {
        print("MQTT session disconnected.")
        if error != .none {
            print(error.description)
        }
        print("MQTT Reconnecting")
        establishConnection()
    }

    func mqttDidAcknowledgePing(from session: MQTTSession) {
        print("MQTT deep-alive ping acknowledged.")
    }

    // MQTT non-delegate methods
    func establishConnection() {
        let host = "localhost"
        let port: UInt16 = 1883
        let clientID = self.clientID()
        
        mqttSession = MQTTSession(host: host, port: port, clientID: clientID, cleanSession: true, keepAlive: 15, useSSL: false)
        mqttSession.delegate = self
        print("MQTT trying to connect to \(host) on port \(port) for clientID \(clientID)")

        mqttSession.connect { (error) in
            if error == .none {
                print("MQTT connected.")
                self.subscribeToChannel()
            } else {
                print("MQTT error occurred during connection:")
                print(error.description)
            }
        }
    }
    
    func subscribeToChannel() {
        let channel = "#"
        print("MQTT subscribing to \(channel)")
        mqttSession.subscribe(to: channel, delivering: .exactlyOnce) { (error) in   //QOS0
            if error == .none {
                print("MQTT subscribed to \(channel)")
                self.syncStatus()
            } else {
                print("MQTT error occurred during subscription:")
                print(error.description)
            }
        }
    }
    
    func clientID() -> String {

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
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

// For now we're loading from a json file.
// Later we'll want to loud from iCloud or another cloud server
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



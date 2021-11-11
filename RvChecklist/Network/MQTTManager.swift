//
//  MQTTManager.swift
//  RvChecklist
//
//  Created by Ron Lisle on 10/23/21.
//

import SwiftMQTT
import Foundation

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

    let host = "192.168.50.33"      // "localhost" for testing, else 192.168.50.33
    let port: UInt16 = 1883
    let subscribeTopic = "#"
    var clientID: String = ""

    var session: MQTTSession?
    var messageHandler: ((String, String) -> Void)?
    
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
                session = nil
            }
        }
    }

    private func subscribe() {
        print("Subscribing...")
        session?.subscribe(to: subscribeTopic, delivering: .exactlyOnce) { (error) in
            print("Subscribe completed, error: \(error)")
            if error == .none {
                self.isSubscribed = true
//                self.requestUpdates()
            } else {
                print("MQTT subscription error:")
                print(error.description)
            }
        }
        //debug
        self.requestUpdates()

    }

    private func requestUpdates() {
        // This requests every patriot controller to send its current devices states
        publish(topic: "patriot/query", message: "All")
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
            handler(message.topic, message.stringRepresentation ?? "")
        }
    }

    func mqttDidDisconnect(session: MQTTSession, error: MQTTSessionError) {
        print("MQTT session disconnected.")
        if error != .none {
            print(error.description)
        }
        self.session = nil
        //TODO: try to reconnect
        //print("MQTT Reconnecting")
        //connect()     //TODO: implement retry counter
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

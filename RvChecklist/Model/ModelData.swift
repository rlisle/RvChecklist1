//
//  ModelData.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/20/21.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    
    @Published var checklist: [ChecklistItem] = []
    
    let mqtt: MQTTManager!
    
    init(mqttManager: MQTTManager) {
        mqtt = mqttManager
        mqtt.messageHandler = { topic, message in
            //TODO: refactor
            // t: patriot/state/<device> m:<value>
            if topic.hasPrefix("patriot/state/") {
                let components = topic.components(separatedBy: "/")
                if components.count > 2 {
                    self.setItem(device: components[2], value: message)
                }
            }
        }
        
        // Load items after MQTT is initialized
        initializeList()
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
    
    private func setItem(device: String, value: String) {
        for index in 0..<checklist.count {
            if checklist[index].id.lowercased() == device.lowercased() {
                print("DEBUG: setting device \(device) to \(value)")
                checklist[index].isDone = value != "0"
            }
        }
    }
}

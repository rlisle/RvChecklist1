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
            // t: patriot/state/ALL/X/<checklistitem> m:<0|1>
            let lcTopic: String = topic.lowercased()
            if lcTopic.hasPrefix("patriot/state/all/x/") {
                let components = lcTopic.components(separatedBy: "/")
                if components.count > 4 {
                    self.setItem(checklistitem: components[4], value: message)
                }
            }
        }
        
        // Load items after MQTT is initialized
        initializeList()
        for i in 0..<checklist.count {
            checklist[i].mqtt = self.mqtt
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
    
    // Called when MQTT reports on a checklist item (patriot/state/all/x/<checklistitem>
    private func setItem(checklistitem: String, value: String) {
        for index in 0..<checklist.count {
            if checklist[index].id.lowercased() == checklistitem.lowercased() {
                print("DEBUG: setting checklistitem \(checklistitem) to \(value)")
                checklist[index].isDone = value != "0"
            }
        }
    }
}

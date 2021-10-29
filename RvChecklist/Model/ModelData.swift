//
//  ModelData.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/20/21.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    
    @Published var checklist: [ChecklistItem] = load("checklistData.json")
    
    let mqtt: MQTTManager!
    
    init(mqttManager: MQTTManager) {
        mqtt = mqttManager
        mqtt.messageHandler = { topic, message in
            if topic.hasPrefix("patriot/state/") {
                self.setItem(fromTopic: topic, fromMessage: message)
            }
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

extension ModelData {
    private func setItem(fromTopic: String, fromMessage: String) {
        // t: patriot/state/<device> m:<value>
        // First part of topic already checked above by caller
        let components = fromTopic.components(separatedBy: "/")
        guard components.count > 2 else {
            return
        }
        let device = components[2].lowercased()
        for index in 0..<checklist.count {
            if checklist[index].id == device {  // TODO: s/b case insensitive
                checklist[index].isDone = fromMessage != "0"
            }
        }
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

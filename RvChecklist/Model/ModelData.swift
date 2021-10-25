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
            if topic.hasPrefix("patriot/checklist") {
                self.setItem(fromMessage: message)
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
    private func setItem(fromMessage: String) {
        let components = fromMessage.components(separatedBy: ":")
        if components.count > 1 {
            let newState = components[1] == "1"
            for index in 0..<checklist.count {
                if checklist[index].id == components[0] {
                    checklist[index].isDone = newState
                }
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

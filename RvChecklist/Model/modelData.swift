//
//  modelData.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/20/21.
//

import Foundation
import Combine

/**
 Model data consists of merging:
 1. Trips
 2. DoneItems
 3. ChecklistDescriptions
 Initially, all 3 will be combined into ChecklistItem
 Later these will be split out into separate, related items.
 */
final class ModelData: ObservableObject {
    @Published var checklist: [ChecklistItem] = load("checklistData.json")

    func checklist(category: String) -> [ChecklistItem] {
        return checklist.filter { $0.category == category }
    }

    func trips() -> [String] {
        //TODO: Sort chronologically or alphabetically
        return Array(Set(checklist.map { $0.trip } ))
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

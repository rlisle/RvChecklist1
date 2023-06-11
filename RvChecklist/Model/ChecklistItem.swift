//
//  ChecklistItem.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/12/21.
//

import Foundation
import SwiftData

@Model
class ChecklistItem {

    var name: String        // Used by device (eg. RearAwning) MQTT status
    var title: String       // Title
    var category: String    // Pre-Trip, Departure, Arrival
    var order: Int          // Display sort order
    var text: String // Markdown?
    var isDone: Bool // = false {
//        didSet {
//            print("didSet \(id) to \(isDone)")
//            if oldValue != isDone {
//                print("Value changed, sending MQTT message")
//                mqtt?.publish(topic: "patriot/\(id)", message: isDone ? "100" : "0")
//            }
//        }
//    }
    var imageName: String?

//    weak var mqtt: MQTTManager?

    init(name: String, title: String, category: String, order: Int, text: String, imageName: String? = nil) {
        self.name = name
        self.title = title
        self.category = category
        self.order = order
        self.text = text
        self.imageName = imageName
        isDone = false
    }
}

extension ChecklistItem: Identifiable {
    static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
        return lhs.name == rhs.name
        && lhs.title == rhs.title
        && lhs.category == rhs.category
    }
}

extension ChecklistItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(title)
        hasher.combine(category)
    }
}

extension Array where Element == ChecklistItem {
    
    func category(_ selected: String) -> [ChecklistItem] {
        return filter { $0.category.caseInsensitiveCompare(selected) == .orderedSame }
    }
    
    func done() -> [ChecklistItem] {
      return filter { $0.isDone }
    }
    
    func todo() -> [ChecklistItem] {
      return filter { $0.isDone == false }
    }
}

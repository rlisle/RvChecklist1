//
//  ChecklistItem.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/12/21.
//

import SwiftUI

struct ChecklistItem {
    let title: String
    let description: String
    let imageName: String
    var isDone = false
}

extension ChecklistItem: Hashable, Identifiable {
  var id: some Hashable { title }
}

struct Checklist {
    let name: String
    let list: [ChecklistItem]
}

extension Checklist: Hashable, Identifiable {
  var id: some Hashable { name }
}

struct Checklists {
    
    static let placeholder = "camera"
    
    static let lists: [Checklist] = [
        Checklist(name: "Pre-Trip",
                  list: [
                    ChecklistItem(title: "Start Checklist", description: "Start new checklist", imageName: placeholder, isDone: true),
                    ChecklistItem(title: "Tire Air Pressures", description: "Check all tire pressures: Truck Front ??, Rear ??, RV ?? psi", imageName: placeholder),
                  ]),
        Checklist(name: "Departure",
                  list: [
                    ChecklistItem(title: "Retract Bedroom slide", description: "Retract Bedroom Slide", imageName: placeholder),
                    ChecklistItem(title: "Retract Main Slides", description: "Retract Livingroom Slides", imageName: placeholder),
                    ChecklistItem(title: "Retract Ramp Awning", description: "Retract Ramp Awning", imageName: placeholder),
                    ChecklistItem(title: "Close Ramp", description: "Close and latch ramp", imageName: placeholder),
                    ChecklistItem(title: "Door Handles", description: "Close both door handles so they prevent the door from opening", imageName: placeholder),
                    ChecklistItem(title: "Retrace Rear Awning", description: "Retract Rear Awning", imageName: placeholder),
                    ChecklistItem(title: "Retract Front Awning", description: "Retract Front Awning", imageName: placeholder)
                  ]),
        Checklist(name: "Arrival",
                  list: [
                    ChecklistItem(title: "Extend Landing Gear", description: "Unpack pads, then extend landing gear until kingpin just begins to lift off of 5th wheel", imageName: placeholder),
                  ]),
        Checklist(name: "Freeze",
                  list: [
                  ]),
        Checklist(name: "Thaw",
                  list: [
                  ]),
        Checklist(name: "Maintenance",
                  list: [
                  ])
    ]
    
    static func checklist(named: String) -> [ChecklistItem] {
        return lists.filter { $0.name == named }.first!.list
    }
}


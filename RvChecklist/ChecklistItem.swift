//
//  ChecklistItem.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/12/21.
//

import SwiftUI

struct ChecklistItem {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    var isDone = false
}

extension ChecklistItem: Identifiable { }

let placeholder = "camera"

let checklistData = [
    ChecklistItem(title: "Start Checklist", description: "Start new checklist", imageName: placeholder, isDone: true),
    ChecklistItem(title: "Retract Bedroom slide", description: "Retract Bedroom Slide", imageName: placeholder),
    ChecklistItem(title: "Retract Main Slides", description: "Retract Livingroom Slides", imageName: placeholder),
    ChecklistItem(title: "Retract Ramp Awning", description: "Retract Ramp Awning", imageName: placeholder),
    ChecklistItem(title: "Close Ramp", description: "Close and latch ramp", imageName: placeholder),
    ChecklistItem(title: "Close door handles", description: "Close both door handles", imageName: placeholder),
    ChecklistItem(title: "Retrace Rear Awning", description: "Retract Rear Awning", imageName: placeholder),
    ChecklistItem(title: "Retract Front Awning", description: "Retract Front Awning", imageName: placeholder)
]

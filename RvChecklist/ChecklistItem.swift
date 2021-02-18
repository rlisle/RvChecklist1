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
                    ChecklistItem(title: "Extend Landing Gear", description: "Unpack pads, then extend landing gear until kingpin just begins to lift off of 5th wheel", imageName: placeholder)
                  ]),
        Checklist(name: "Freeze",
                  list: [
                    ChecklistItem(title: "Fill water tank", description: "Fill fresh water tank", imageName: placeholder),
                    ChecklistItem(title: "Fill collapsing water jugs", description: "Fill backup water jugs", imageName: placeholder),
                    ChecklistItem(title: "Drip Faucets", description: "Set all faucets to slow drip", imageName: placeholder),
                    ChecklistItem(title: "Install heated water hose", description: "Replace regular water hose with electric heated hose", imageName: placeholder),
                    ChecklistItem(title: "Disconnect & drain other hoses", description: "Disconnect and drain other garden hoses, etc.", imageName: placeholder),
                    ChecklistItem(title: "Cover water post", description: "Use a large plastic bag and towels or blankets to insulate the water post", imageName: placeholder),
                    ChecklistItem(title: "Insulate Windows", description: "Cover windows with blankets", imageName: placeholder),
                    ChecklistItem(title: "Close Ramp", description: "Close ramp", imageName: placeholder),
                    ChecklistItem(title: "Cover A/C Units", description: "Cover roof A/C units with large plastic bags and duck tape", imageName: placeholder),
                    ChecklistItem(title: "Seal Slide-Out Edges", description: "Seal slide-out edges with cloth snakes to prevent air leaks", imageName: placeholder)
                  ]),
        Checklist(name: "Thaw",
                  list: [
                    ChecklistItem(title: "Replace heated water host", description: "Remove heated water hose and replace with normal hose", imageName: placeholder),
                    ChecklistItem(title: "Uncover A/C Units", description: "Remove plastic wrapping on roof A/C units", imageName: placeholder)
                  ]),
        Checklist(name: "Maintenance",
                  list: [
                    ChecklistItem(title: "Run generator monthly", description: "Start generator, then turn off power post breaker. Let generator run for 15-30 minutes. Run with 1 A/C unit on if possible", imageName: placeholder),
                    ChecklistItem(title: "Inspect roof monthly", description: "Check all seals on roof for cracks. Check A/C units for pests. Clean out gutters.", imageName: placeholder)
                  ])
    ]
    
    static func checklist(named: String) -> [ChecklistItem] {
        return lists.filter { $0.name == named }.first!.list
    }
}


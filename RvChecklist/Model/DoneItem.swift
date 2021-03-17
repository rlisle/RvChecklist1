//
//  DoneItem.swift
//  RvChecklist
//
//  Created by Ron Lisle on 3/15/21.
//

import Foundation

struct DoneItem: Identifiable, Hashable, Codable {
    let id: Int
    let tripId: Int
    let checklistId: Int
    let isDone: Bool
}

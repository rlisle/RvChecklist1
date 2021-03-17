//
//  ChecklistItem.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/12/21.
//

import SwiftUI

struct ChecklistItem: Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let category: String
    let description: String
    let trip: String
//    let date: Date
    var isDone: Bool
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

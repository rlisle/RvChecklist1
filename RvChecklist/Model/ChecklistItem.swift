//
//  ChecklistItem.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/12/21.
//

import SwiftUI

struct ChecklistItem: Identifiable, Hashable, Codable {
    let id: String          // Used by device
    let name: String        // Title
    let category: String    // Pre-Trip, Departure, Arrival
    let order: Int          // Display sort order
    let description: String // Markdown?
    var isDone: Bool
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

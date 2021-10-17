//
//  ChecklistItem.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/12/21.
//

import SwiftUI

struct ChecklistItem: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let category: String
    let order: Int
    let description: String
    var isDone: Bool
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

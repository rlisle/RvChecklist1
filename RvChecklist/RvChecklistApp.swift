//
//  RvChecklistApp.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/11/21.
//

import SwiftUI

@main
struct RvChecklistApp: App {
    
    @StateObject private var modelData = ModelData()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ChecklistView()
                .environmentObject(modelData)
        }
    }
}

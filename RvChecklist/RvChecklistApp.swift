//
//  RvChecklistApp.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/11/21.
//

import SwiftUI
import SwiftData

@main
struct RvChecklistApp: App {
    
    @StateObject var model = ModelData(mqttManager: MQTTManager())
    
    var body: some Scene {
        WindowGroup {
            ChecklistView()
            .environmentObject(model)
        }
        .modelContainer(for: ChecklistItem.self)
    }
}

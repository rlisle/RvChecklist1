//
//  RvChecklistApp.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/11/21.
//

import SwiftUI

@main
struct RvChecklistApp: App {
    
    // This is our dependency injection.
    // Previews & Tests can inject fake data
    @StateObject private var modelData = ModelData(mqttManager: MQTTManager())
    
    var body: some Scene {
        WindowGroup {
            ChecklistView()
                .environmentObject(modelData)
        }
    }
}

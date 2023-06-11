//
//  PreviewSampleData.swift
//  RvChecklist
//
//  Created by Ron Lisle on 6/10/23.
//

import SwiftUI
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: ChecklistItem.self, ModelConfiguration(inMemory: true)
        )
        for item in SeedData.contents {
            container.mainContext.insert(object: item)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

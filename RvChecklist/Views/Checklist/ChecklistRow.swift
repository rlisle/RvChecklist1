//
//  ChecklistRow.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/22/21.
//

import SwiftUI

struct ChecklistRow: View {
    
    @EnvironmentObject var modelData: ModelData
    var listItem: ChecklistItem

    var listItemIndex: Int {
        modelData.checklist.firstIndex(where: { $0.id == listItem.id })!
    }

    var body: some View {

        HStack {
            Text(listItem.name).strikethrough(listItem.isDone)
            Spacer()
            Checkmark(isDone: $modelData.checklist[listItemIndex].isDone)
        }
    }
}

struct ChecklistRow_Previews: PreviewProvider {
    static let modelData = ModelData(mqttManager: MQTTManager())
    static var previews: some View {
        ChecklistRow(listItem: modelData.checklist[0])
            .environmentObject(modelData)
            .previewLayout(.fixed(width: 300, height: 40))
            .previewDisplayName("ChecklistRow")

    }
}

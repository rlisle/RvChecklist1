//
//  ChecklistRow.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/22/21.
//

import SwiftUI

struct ChecklistRow: View {
    let listItem: ChecklistItem
    let action: () -> Void

    var body: some View {

        HStack {
            Text(listItem.title).strikethrough(listItem.isDone)
            Spacer()
            Checkmark(isDone: listItem.isDone) {
                action()
            }
        }
    }
}

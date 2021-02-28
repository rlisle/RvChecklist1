//
//  ChecklistScrollView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/22/21.
//

import SwiftUI

struct ChecklistScrollView: View {

    @EnvironmentObject var modelData: ModelData
    //TODO: category will identify the scroll-to point
    var category: String

    var filteredChecklist: [ChecklistItem] {
        modelData.checklist.filter { item in
               (item.category == category)
           }
       }

    var body: some View {
        NavigationView {
//            List(filteredChecklist) { listItem in
            List {
                ForEach(filteredChecklist) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
                    }
            }
            .navigationTitle(category)
            .listStyle(PlainListStyle())
        }
    }
}

struct ChecklistScrollView_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        ChecklistScrollView(category: "Departure")
            .environmentObject(modelData)
    }
}

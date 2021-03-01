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

    var preTripChecklist: [ChecklistItem] {
        modelData.checklist.filter { item in
               (item.category == "Pre-Trip")
           }
       }

    var departureChecklist: [ChecklistItem] {
        modelData.checklist.filter { item in
               (item.category == "Departure")
           }
       }
    
    var arrivalChecklist: [ChecklistItem] {
        modelData.checklist.filter { item in
               (item.category == "Arrival")
           }
       }
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Pre-Trip")) {
                    ForEach(preTripChecklist) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
                    }
                }
                Section(header: Text("Departure")) {
                    ForEach(departureChecklist) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
                    }
                }
                Section(header: Text("Arrival")) {
                    ForEach(arrivalChecklist) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
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

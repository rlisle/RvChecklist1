//
//  ChecklistScrollView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/22/21.
//

import SwiftUI

struct ChecklistScrollView: View {

    @EnvironmentObject var modelData: ModelData
    var showCompleted: Bool

    var preTripChecklist: [ChecklistItem] {
        modelData.checklist.filter { item in
               (item.category == "Pre-Trip"
                    && (item.isDone == false
                        || showCompleted == true))
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
                Section(header: Text("Pre-Trip (\(preTripChecklist.count) items)")) {
                    ForEach(preTripChecklist) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
                    }
                }
                Section(header: Text("Departure (\(departureChecklist.count) items)")) {
                    ForEach(departureChecklist) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
                    }
                }
                Section(header: Text("Arrival (\(arrivalChecklist.count) items)")) {
                    ForEach(arrivalChecklist) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .animation(.easeInOut)
        }
    }
}

struct ChecklistScrollView_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        ChecklistScrollView(showCompleted: true)
            .environmentObject(modelData)
    }
}

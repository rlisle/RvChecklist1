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

    func category(_ category: String) -> [ChecklistItem] {
        return modelData.checklist.filter { $0.category == category }
    }
    
    func done(_ list: [ChecklistItem]) -> [ChecklistItem] {
        return list.filter { $0.isDone == true }
    }
    
    func todo(_ list: [ChecklistItem]) -> [ChecklistItem] {
        return list.filter { $0.isDone == false }
    }

    var body: some View {
        NavigationView {
            List {
                let pretrip = category("Pre-Trip")
                var filteredPretrip = showCompleted ? pretrip : todo(pretrip)
                Section(header: Text("Pre-Trip (\(todo(pretrip).count) of \(pretrip.count) items)")) {
                    ForEach(filteredPretrip) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
                    }
                }
                let departure = category("Departure")
                var filteredDeparture = showCompleted ? departure : todo(departure)
                Section(header: Text("Departure (\(todo(departure).count) of \(departure.count) items)")) {
                    ForEach(filteredDeparture) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
                    }
                }
                let arrival = category("Arrival")
                var filteredArrival = showCompleted ? arrival : todo(arrival)
                Section(header: Text("Arrival (\(todo(arrival).count) of \(arrival.count) items)")) {
                    ForEach(filteredArrival) { listItem in
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
        ChecklistScrollView(showCompleted: false)
            .environmentObject(modelData)
    }
}

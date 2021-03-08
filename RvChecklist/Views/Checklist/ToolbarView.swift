//
//  ToolbarView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/27/21.
//

import SwiftUI

struct ToolbarView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        Menu {

            Section {
                Button("Start New Trip") {
                    startNewTrip()
                }
            }
            Section(header: Text("Current")) {
                Text("<todo>")
            }
            Section(header: Text("Previous")) {
                Text("<todo>")
            }

        } label: {
            Text("Trips" /*, systemImage:"ellipsis.circle.fill"*/)
        }
        .foregroundColor(.white)
        .font(.subheadline)
    }
    
    func startNewTrip() {
        //TODO: display screen to enter name, date, etc.
        
        // then clear isDone on all trip items
        clearChecklist(category: "Pre-Trip")
        clearChecklist(category: "Departure")
        clearChecklist(category: "Arrival")
    }
    
    func clearChecklist(category: String?) {
        for index in 0..<modelData.checklist.count {
            if modelData.checklist[index].category == category {
                print("Clearing item")
                modelData.checklist[index].isDone = false
            }
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
            .environmentObject(ModelData())
    }
}

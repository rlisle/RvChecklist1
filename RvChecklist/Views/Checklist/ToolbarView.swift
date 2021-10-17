//
//  ToolbarView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/27/21.
//

import SwiftUI

struct ToolbarView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isPresented: Bool
    
    var body: some View {
        
        Menu {

            Section {
                Button("Add New Trip") {
                    startNewTrip()
                }
            }
            Section(header: Text("Current")) {
                Text("<TODO: current trip>")
            }
            Section(header: Text("Previous")) {
                Text("<TODO: previous trip>")
            }

        } label: {
            Text("Trips" /*, systemImage:"ellipsis.circle.fill"*/)
                .foregroundColor(.white)
                .font(.headline)
                .padding(2)
                .background(Color(.gray))
                //.opacity(0.5)
        }
    }
    
    func startNewTrip() {
        //TODO: display screen to enter name, date, etc.
        isPresented.toggle()
        
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
        ToolbarView(isPresented: false)
            .environmentObject(ModelData(mqttManager: MQTTManager()))
    }
}

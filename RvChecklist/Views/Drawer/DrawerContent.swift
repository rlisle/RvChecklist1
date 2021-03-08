//
//  DrawerContent.swift
//  RvChecklist
//
//  Created by Ron Lisle on 3/6/21.
//

import SwiftUI

struct DrawerContent: View {
    @EnvironmentObject var modelData: ModelData
//    @Binding var showCompleted: Bool
    
    var body: some View {
        
        List {

//            Section(header: Text("List Type")) {
//                //TODO: map/reduce unique list of categories
//                ForEach(Array(Set(modelData.checklist.map { $0.category })), id: \.self) { list in
//                    Button(list) {
//                        //
//                        category = list
//                    }
//                }
//            }

            Section {
                Button("Start New Trip") {
                    startNewTrip()
                }
            }
//            Section {
//                Toggle("Show Completed Items", isOn: $showCompleted)
//            }

        }
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

struct DrawerContent_Previews: PreviewProvider {
    static var previews: some View {
        DrawerContent()
    }
}

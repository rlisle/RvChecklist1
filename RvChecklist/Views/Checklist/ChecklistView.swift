//
//  ChecklistView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/11/21.
//

import SwiftUI

struct ChecklistView: View {

    @EnvironmentObject var modelData: ModelData
    @State private var category = "Pre-Trip"

    init() {
         UINavigationBarAppearance().configureWithTransparentBackground()
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                ChecklistHeader()
                ChecklistScrollView(category: category)
            }
            .edgesIgnoringSafeArea([.top])
            .toolbar {
                ToolbarItem {
                    Menu {
                        
                        Section(header: Text("List Type")) {
                            //TODO: map/reduce unique list of categories
                            ForEach(Array(Set(modelData.checklist.map { $0.category })), id: \.self) { list in
                                Button(list) {
                                    //
                                    category = list
                                }
                            }
                        }
                        
                        Section {
                            Button("Start New Trip") {
                                startNewTrip()
                            }
                            Button("New Freeze") {
                                startNewFreeze()
                            }
                        }
                        
                    } label: {
                        Label("", systemImage:"ellipsis.circle.fill")
                    }
                    .foregroundColor(.white)
                    .font(.subheadline)
                }
            }
        }
    }
    
    func startNewTrip() {
        //TODO: display screen to enter name, date, etc.
        
        // then clear isDone on all trip items
        clearChecklist(category: "Pre-Trip")
        clearChecklist(category: "Departure")
        clearChecklist(category: "Arrival")
    }
    
    func startNewFreeze() {
        //TODO: enter freeze date
        
        // then clear isDone on all freeze/thaw items
        clearChecklist(category: "Freeze")
        clearChecklist(category: "Thaw")
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

private extension Array where Element == ChecklistItem {
    mutating func toggleDone(to item: ChecklistItem) {
        guard let index = self.firstIndex( where: { $0 == item }) else { return }
        self[index].isDone.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPhone 11 Pro"], id: \.self) { deviceName in
                ChecklistView()
                    .environmentObject(ModelData())
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
}


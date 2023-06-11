//
//  ChecklistView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/11/21.
//

import SwiftUI
import SwiftData

struct ChecklistView: View {

    @Query private var checklistItems: [ChecklistItem]
    
    @State private var showCompleted = true
    @State private var showSettings = false
    @State private var menuSelection: String? = nil
    private var phases = ["Pre-Trip", "Departure", "Arrival"]

    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                ChecklistHeader()
                List {
                    ForEach(phases, id: \.self) { phase in
                        Section(header:
                                    HStack {
                            Text(phase)
                            Spacer()
                            Text("(\(checklistItems.category(phase).done().count) of \(checklistItems.category(phase).count) done)")
                        }
                            .padding(.vertical, 8)
                        ) {
                            if(checklistItems.category(phase).todo().count == 0) {
                                Text("No \(phase) items found")
                            } else {
                                ForEach(checklistItems.category(phase).filter { isShown(item:$0) }, id: \.self) { item in
                                    NavigationLink(destination: DetailView(listItem: item)) {
                                        Text("\(item.title)")
                                        //ChecklistRow(listItem: item)
                                    }
                                }
                            }
                        }
                        .textCase(nil)
                    }// foreach phase
                } // List
                .padding(.top, -8)
                .listStyle(PlainListStyle())    // Changed from GroupedListStyle
                //.animation(.easeInOut)
            }//VStack
            .blackNavigation
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("RV Checklist")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            self.showCompleted.toggle()
                        }
                    }) {
                        Image(systemName: showCompleted ? "checklist" : "checklist.unchecked")
                            .imageScale(.large)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            self.showSettings.toggle()
                        }
                    }) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                    }
                }
            }
        }//NavigationView
        .accentColor(.white)   // Sets back button color
        
    }
        
    func isShown(item: ChecklistItem) -> Bool {
        return showCompleted == true || item.isDone == false
    }

}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ForEach(["iPhone 14 Pro", "iPad (10th generation)"], id: \.self) { deviceName in
//                ChecklistView()
//                    .environmentObject(ModelData(mqttManager: MQTTManager()))
//                    .previewDevice(PreviewDevice(rawValue: deviceName))
//                    .previewDisplayName(deviceName)
//            }
//        }
//    }
//}

#Preview { @MainActor in
    ChecklistView()
//        .frame(minWidth: 500, minHeight: 500)
        .modelContainer(previewContainer)
}

//
//  ChecklistView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/11/21.
//

import SwiftUI

struct ChecklistView: View {

    @EnvironmentObject var modelData: ModelData
    
    @State private var showCompleted = true
    @State private var showMenu = false
    @State private var menuSelection: String? = nil
    private var phases = ["Pre-Trip", "Departure", "Arrival"]

    var body: some View {
        
        NavigationView {

            GeometryReader { geometry in

                ZStack(alignment: .leading) {   // for sidemenu
                    
                    VStack {
                        
                        ChecklistHeader()

                        // Checklist Section
                        List {
                            
                            ForEach(phases, id: \.self) { phase in
                                Section(header:
                                            HStack {
                                    Text(phase)
                                    Spacer()
                                    Text("(\(modelData.numSelectedDone(category: phase)) of \(modelData.numSelectedItems(category: phase)) done)")
                                }
                                    .padding(.vertical, 8)
                                ) {
                                    
                                    
                                    if(modelData.numSelectedItems(category: phase) == 0) {
                                        Text("No \(phase) items found")
                                    } else {
                                        ForEach(modelData.checklist(category: phase).filter { isShown(item:$0) }, id: \.self) { item in
                                            
                                            NavigationLink(destination: DetailView(listItem: item)) {
                                                ChecklistRow(listItem: item)
                                            }
                                        }
                                    }
                                    
                                }
                                .textCase(nil)
                                
                            }// phases

                        } // List
                        .padding(.top, -8)
                        .listStyle(PlainListStyle())

                        
                    }//VStack
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        // Close side menu (This breaks onMove
                        let drag = DragGesture()
                            .onEnded {
                                if $0.translation.width < -100 {
                                    withAnimation {
                                        self.showMenu = false
                                    }
                                }
                            }

                        MenuView(showMenu: $showMenu,
                                 showCompleted: $showCompleted,
                                 selection: $menuSelection)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                        .gesture(drag)

                    }

                }//ZStack for sidemenu
                .blackNavigation
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("RV Checklist")
                .toolbar {
                     ToolbarItem(placement: .navigationBarLeading) {
                         Button(action: {
                             withAnimation {
                                 self.showMenu.toggle()
                             }
                         }) {
                             Image(systemName: "line.horizontal.3")
                                 .imageScale(.large)
                         }
                     }
                }
            } //GeometryReader
        }//NavigationView
        .accentColor(.white)
    }
        
    func isShown(item: ChecklistItem) -> Bool {
        return showCompleted == true || item.isDone == false
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPhone 14 Pro", "iPad (10th generation)"], id: \.self) { deviceName in
                ChecklistView()
                    .environmentObject(ModelData(mqttManager: MQTTManager()))
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
}

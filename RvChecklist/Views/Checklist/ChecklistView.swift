//
//  ChecklistView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/11/21.
//

import SwiftUI

struct ChecklistView: View {

    @EnvironmentObject var modelData: ModelData
    
    @State private var showCompleted = false
//    @State var isPresented = false
    @State private var showMenu = false
    @State private var menuSelection: String? = nil
    @State private var phase = "Pre-Trip"
    private var phases = ["Pre-Trip", "Departure", "Arrival"]

    init() {
         UINavigationBarAppearance().configureWithTransparentBackground()
    }
    
    var body: some View {
        
        NavigationView {

            GeometryReader { geometry in

                ZStack(alignment: .leading) {   // for sidemenu
                    
                    // Omitting AddItem NavigationLink
                    
                    VStack {
                        
                        ChecklistHeader()

                        Picker(selection: $phase, label: Text("Phase")) {
                            ForEach(phases, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom, 0)
                        .background(Color.black)

                        // Checklist Section
                        List {
                            
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
                                    ForEach(modelData.checklist(category: phase)) { item in
                                        
                                      NavigationLink(destination: DetailView(listItem: item)) {
                                          ChecklistRow(listItem: item)
                                      }
                                    }
                                    .onMove(perform: onMove)
                                    .onDelete(perform: onDelete)
                                }


                            } // Pre-Trip Section
                            .textCase(nil)
                            

                        } // List
                        .padding(.top, -8)
                        .listStyle(PlainListStyle())    // Changed from GroupedListStyle
                        //.animation(.easeInOut)

                        
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
                .navigationBarTitle("RV Checklist", displayMode: .inline)
                .navigationBarItems(
                    leading: (
                        Button(action: {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        }
                    ),
                    trailing: (
                        HStack {
                            EditButton()
                            Button(action: {
                                menuSelection = "Add"
                            }) {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                            }
                        }
                    )
                ) // navigationBarItems

                
            } //GeometryReader
//            .edgesIgnoringSafeArea([.top])
        }//NavigationView
        .accentColor( .black)   // Sets back button color

    }
        
    private func onDelete(offsets: IndexSet) {
        print("onDelete \(offsets)")
//        for index in offsets {
//            let item = items.filter { isShown(item:$0) && $0.category == phase }[index]
//            viewContext.delete(item)
//        }
    }

    // There's a bug that causes onMove to break if another gesture recognizer is attached.
    private func onMove(source: IndexSet, destination: Int) {
//        let list = items.filter { isShown(item:$0) && $0.category == phase }
//        var revisedItems = list.sorted(by: { $0.sequence < $1.sequence })
//        revisedItems.move(fromOffsets: source, toOffset: destination)
//        var index: Int16 = 1000    // TODO: may want to set different values for each category
//        for item in revisedItems {
//            item.sequence = index
//            index += 10
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            print("Error saving updated sequences: \(nsError), \(nsError.userInfo)")
//        }
    }

//    func numSelectedDone() -> Int {
//        return modelData.listItems.filter { $0.category == phase && $0.isDone }.count
//    }
//    
//    func numSelectedItems() -> Int {
//        return modelData.listItems.filter { $0.category == phase }.count
//    }
    
    func isShown(item: ChecklistItem) -> Bool {
        return showCompleted == true || item.isDone == false
    }


}

//private extension Array where Element == ChecklistItem {
////    mutating func toggleDone(checkListId: Int, tripId: Int) {
////        //TODO:
//////        guard let index = self.firstIndex( where: { $0 == item }) else { return }
//////        self[index].isDone.toggle()
////    }
//}

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

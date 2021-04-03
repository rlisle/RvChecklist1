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
    @State var isPresented = false

    init() {
         UINavigationBarAppearance().configureWithTransparentBackground()
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                ChecklistHeader()
                NavigationView {
                    VStack {
                        Toggle("Show Completed Items", isOn: $showCompleted)
                            .padding([.all],16)
                            .padding(EdgeInsets(top: -12, leading: 16, bottom: -12, trailing: 4))
                    ChecklistScrollView(showCompleted: showCompleted)
                    .navigationBarHidden(true)
                    .animation(.easeInOut)
                    .padding([.horizontal], -16)
                    }
                }
            }
//            .sheet(isPresented: $isPresented) {
//                Text("TODO:")
//                self.isPresented = false
//            }
            .edgesIgnoringSafeArea([.top])
//            .toolbar {
//                ToolbarItem(placement: .primaryAction) {
//                    ToolbarView(isPresented: isPresented)
//                }
//            }
        }
    }
    
//    func deleteTrip(at offsets: IndexSet) {
//      trips.remove(atOffsets: offsets)
//    }

//    func addTrip(destination: String, description: String, date: Date) {
//        let newTrip = Trip(destinationName: destination, description: description, date: date)
//      movies.append(newMovie)
//    }

}

private extension Array where Element == ChecklistItem {
    mutating func toggleDone(checkListId: Int, tripId: Int) {
        //TODO:
//        guard let index = self.firstIndex( where: { $0 == item }) else { return }
//        self[index].isDone.toggle()
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

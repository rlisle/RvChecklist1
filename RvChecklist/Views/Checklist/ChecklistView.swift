//
//  ChecklistView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/11/21.
//

import SwiftUI

struct ChecklistView: View {

    init() {
         UINavigationBarAppearance().configureWithTransparentBackground()
    }
    
    @EnvironmentObject var modelData: ModelData
    @State private var category = "Pre-Trip"

    var filteredChecklist: [ChecklistItem] {
        modelData.checklist.filter { item in
               (item.category == category)
           }
       }

    var body: some View {
        
        NavigationView {
            
            VStack {
                ChecklistHeader()
//                ChecklistScrollView(category: category)
                NavigationView {
                    List(filteredChecklist) { listItem in
                        NavigationLink(destination: DetailView(listItem: listItem)) {
                            ChecklistRow(listItem: listItem)
                        }
                    }
                    .navigationTitle("Checklist")
                    .listStyle(PlainListStyle())
                }

            }
            .edgesIgnoringSafeArea([.top])
            .toolbar {
                ToolbarItem {
                    Menu("List Type") {
                        //TODO: map/reduce unique list of categories
                        ForEach(Array(Set(modelData.checklist.map { $0.category })), id: \.self) { list in
                            Button(list) {
                                category = list
                            }
                        }
                    }.foregroundColor(.white)
                }
            }
        }
    }
    
    func clearChecklist() {
        for index in 0..<modelData.checklist.count {
            modelData.checklist[index].isDone = false
        }
    }
}

struct ChecklistHeader: View {
    var body: some View {
        ZStack(alignment: .top, content: {
            Image("truck-rv").resizable().aspectRatio(contentMode: .fit)
            Text("RV Checklist").foregroundColor(.white).font(.title2).fontWeight(.semibold).padding(.top, 30)
        })
    }
}

//struct ChecklistScrollView: View {
//
//    @Binding var category = "Departure"
//
//    var filteredChecklist: [ChecklistItem] {
//           checklist.filter { item in
//               (item.category == category)
//           }
//       }
//
//    var body: some View {
//        NavigationView {
//            List(filteredChecklist) { listItem in
//                NavigationLink(destination: DetailView(listItem: listItem)) {
//                    ChecklistRow(listItem: listItem)
//                }
//            }
//            .navigationTitle("Checklist")
//            .listStyle(PlainListStyle())
//        }
//    }
//}

struct ChecklistRow: View {
    
    @EnvironmentObject var modelData: ModelData
    var listItem: ChecklistItem

    var listItemIndex: Int {
        modelData.checklist.firstIndex(where: { $0.id == listItem.id })!
    }

    var body: some View {

        HStack {
            Text(listItem.name).strikethrough(listItem.isDone)
            Spacer()
            Checkmark(isDone: $modelData.checklist[listItemIndex].isDone)
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
//            ChecklistHeader()
//                .previewLayout(.fixed(width: 300, height: 210))
//                .previewDisplayName("Header")
            //ChecklistScrollView(listItems: checklist)
        }
    }
}


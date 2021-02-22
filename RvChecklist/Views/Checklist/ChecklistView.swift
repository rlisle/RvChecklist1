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

    var body: some View {
        
        NavigationView {
            
            VStack {
                ChecklistHeader()
                ChecklistScrollView(category: category)
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


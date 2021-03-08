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
    @State var isDrawerOpen: Bool = false

    init() {
         UINavigationBarAppearance().configureWithTransparentBackground()
    }
    
    var body: some View {
        
        ZStack {
            if !self.isDrawerOpen {
                NavigationView {
                    
                    VStack {
                        ChecklistHeader()
                        Toggle("Show Completed Items", isOn: $showCompleted).padding(16)
                        ChecklistScrollView(showCompleted: showCompleted)
                    }
                    .edgesIgnoringSafeArea([.top])
                         .navigationBarItems(leading: Button(action: {
                             DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                 self.isDrawerOpen.toggle()
                             }
                         }) {
                             Image(systemName: "sidebar.left")
                                .foregroundColor(.white)
                         })

                    //                    .toolbar {
//                        ToolbarItem(placement: .primaryAction) {
//                            ToolbarView(showCompleted: $showCompleted)
//                        }
//                    }
                }
            }
            NavigationDrawer(isOpen: self.isDrawerOpen)

        }
        .background(Color.white)
                .onTapGesture {
                    if self.isDrawerOpen {
                        self.isDrawerOpen.toggle()
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

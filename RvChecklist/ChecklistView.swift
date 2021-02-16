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
    
    @State var listItems: [ChecklistItem] = Checklists.lists[1].list
    
    @State var selectedListType: String?
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                ChecklistHeader()
                ChecklistScrollView(listItems: $listItems)
            }
            .edgesIgnoringSafeArea([.top])
            .toolbar {
                ToolbarItem {
                    Menu("List Type") {
                        ForEach(Checklists.lists) { list in
                            Button(list.name) {
                                selectedListType = list.name
                                listItems = Checklists.checklist(named: selectedListType!)
                            }
                        }
                    }.foregroundColor(.white)
                }
            }
        }
        //                .navigationBarHidden(true)
        .navigationBarTitle("RV Checklist")
        .foregroundColor(.black)
    }
    
    func clearChecklist() {
        for index in 0..<listItems.count {
            listItems[index].isDone = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
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

struct ChecklistScrollView: View {
    
    @Binding var listItems: [ChecklistItem]
    
    var body: some View {
        List(listItems) { listItem in
            NavigationLink(destination: DetailView(listItem: listItem)) {
                HStack {
                    if listItem.isDone {
                        Image(systemName: "checkmark.square")
                    } else {
                        Image(systemName: "square")
                    }
                    Text(listItem.title)
                }
            }
        }.listStyle(PlainListStyle())
    }
}

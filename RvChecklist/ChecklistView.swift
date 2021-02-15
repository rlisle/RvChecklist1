//
//  ChecklistView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/11/21.
//

import SwiftUI

struct ChecklistView: View {

    @State var listItems = checklistData
    
    var body: some View {
        NavigationView {
            VStack {
                ChecklistHeader()

                List(listItems) { listItem in
                    NavigationLink(destination: DetailView(listItem: listItem)) {
                        Text(listItem.title)
                    }
                }.listStyle(PlainListStyle())
                .navigationBarHidden(true)
//                .navigationBarTitle("Checklist")
            }
        }
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
        ZStack(alignment: .leading, content: {
            Image("truck-rv").resizable().aspectRatio(contentMode: .fit)
        })
    }
}

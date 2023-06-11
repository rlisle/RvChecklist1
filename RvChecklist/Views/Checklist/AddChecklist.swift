//
//  AddChecklist.swift
//  RvChecklist
//
//  Created by Ron Lisle on 3/13/21.
//

import SwiftUI
//import MapKit

struct AddChecklist: View {
    static let DefaultName = "TODO:"
    static let DefaultText = "How to do it..."
    static let DefaultCategory = "Pre-Trip"
    
    @State var name = ""
    @State var text = ""
    @State var category = ""
    
    let onComplete: (String, String, String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Checklist Item")) {
                    TextField("", text: $name)
                }
                Section(header: Text("Description")) {
                    TextField("Description", text: $text)
                }
                Section(header: Text("Category")) {
                    TextField("Category", text: $category)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Add Todo")
        }
    }

  private func addItemAction() {
    onComplete(
      name.isEmpty ? AddChecklist.DefaultName : name,
      text.isEmpty ? AddChecklist.DefaultText : text,
        category.isEmpty ? AddChecklist.DefaultCategory : category)
  }
}

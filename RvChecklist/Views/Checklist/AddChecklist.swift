//
//  AddTrip.swift
//  RvChecklist
//
//  Created by Ron Lisle on 3/13/21.
//

import SwiftUI
import MapKit

struct AddChecklist: View {
    static let DefaultTitle = "TODO:"
    static let DefaultDescription = "How to do it..."
    static let DefaultCategory = "Pre-Trip"
    
    @State var title = ""
    @State var description = ""
    @State var category = ""
    
    let onComplete: (String, String, String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Checklist Item")) {
                    TextField("", text: $title)
                }
                Section(header: Text("Description")) {
                    TextField("Description", text: $description)
                }
                Section(header: Text("Category")) {
                    TextField("Category", text: $category)
                }
            }
            .navigationBarTitle(Text("Add Todo"), displayMode: .inline)
        }
    }

  private func addItemAction() {
    onComplete(
      title.isEmpty ? AddChecklist.DefaultTitle : title,
      description.isEmpty ? AddChecklist.DefaultDescription : description,
        category.isEmpty ? AddChecklist.DefaultCategory : category)
  }
}

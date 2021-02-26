//
//  DetailView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/13/21.
//

import SwiftUI

struct DetailView: View {

    @EnvironmentObject var modelData: ModelData
  var listItem: ChecklistItem
  
    var listItemIndex: Int {
        modelData.checklist.firstIndex(where: { $0.id == listItem.id })!
    }

  var body: some View {
    ScrollView {
      Text(listItem.name)                   // Title
        .font(.title2)
        .multilineTextAlignment(.center)
        .lineLimit(3)
        
        Divider()

        Text(listItem.description)          // Description
        .multilineTextAlignment(.leading)
        .lineLimit(20)
        
        Divider()
        
        listItem.image                      // Optional image
        .resizable()
        .frame(maxWidth: 300, maxHeight: 600)
        .aspectRatio(contentMode: .fit)
    }
    .padding()
    .navigationBarTitleDisplayMode(.inline)

  }
}

struct DetailView_Previews: PreviewProvider {
    static let modelData = ModelData()

  static var previews: some View {
    DetailView(listItem: modelData.checklist[1])
        .environmentObject(modelData)
  }
}


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
      Text(listItem.name)
        .font(.title2)
        .multilineTextAlignment(.center)
        .lineLimit(3)
      
//      Button(action: {  }) {
//        HStack(alignment: .firstTextBaseline) {
//          Image(systemName: "mappin.and.ellipse")
//
//          Text(listItem.description)
//            .font(.headline)
//        }
//      }
      
        listItem.image
        .resizable()
        .frame(maxWidth: 300, maxHeight: 600)
        .aspectRatio(contentMode: .fit)
      
      Divider()
      
        Text(listItem.description)
        .multilineTextAlignment(.leading)
        .lineLimit(20)
    }
    .padding()
    .navigationBarTitleDisplayMode(.inline)

  }
}

struct DetailView_Previews: PreviewProvider {
    static let modelData = ModelData()

  static var previews: some View {
    DetailView(listItem: modelData.checklist[0])
        .environmentObject(modelData)
  }
}


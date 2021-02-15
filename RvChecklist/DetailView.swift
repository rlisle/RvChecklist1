//
//  DetailView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/13/21.
//

import SwiftUI

struct DetailView: View {
  let listItem: ChecklistItem
  
  var body: some View {
    VStack {
      Text(listItem.title)
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
      
      Image(listItem.imageName)
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
  static var previews: some View {
    DetailView(listItem: checklistData[0])
  }
}


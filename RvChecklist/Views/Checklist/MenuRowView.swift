//
//  MenuRowView.swift
//  RvChecklist
//
//  Created by Ron Lisle on 7/20/21.
//

import SwiftUI

struct MenuRowView: View {
    
    @State var title: String
    @State var iconName: String
    @State var action: () -> Void
    
    var body: some View {
        
        Button(action: {
            print("Invoking \(title)")
            action()
        }) {
            HStack {
                Image(systemName: iconName)
//                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text(title)
//                    .foregroundColor(.white)
                    .font(.headline)
            }
            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
            .foregroundColor(Color(red: 192/255, green: 192/255, blue: 192/255))
          .padding(.top, 30)
        }
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView(title: "Menu Item", iconName: "person", action: {
            print("Action tapped")
        })
        .previewLayout(.fixed(width: 320, height: 60))
        .previewDisplayName("Checkmark")
    }
}

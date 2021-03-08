//
//  MenuContent.swift
//  RvChecklist
//
//  Created by Ron Lisle on 3/7/21.
//

import SwiftUI

struct MenuContent: View {
    var body: some View {
         List {
             Text("My Profile").onTapGesture {
                 print("My Profile")
             }
             Text("Posts").onTapGesture {
                 print("Posts")
             }
             Text("Logout").onTapGesture {
                 print("Logout")
             }
         }
     }
}

struct MenuContent_Previews: PreviewProvider {
    static var previews: some View {
        MenuContent()
    }
}

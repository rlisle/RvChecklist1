//
//  MenuView.swift
//  RvChecklist
//
//  Side Menu
//
//  Created by Ron Lisle on 7/13/21.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var modelData: ModelData

    @Binding var showMenu: Bool
    @Binding var showCompleted: Bool
    @Binding var selection: String?

    var body: some View {
        VStack(alignment: .leading) {
            
            Section(header: Text("Actions")) {
                
                MenuRowView(title: "Uncheck All", iconName: "square", action: {
                    modelData.uncheckAll()
                    withAnimation {
                        showMenu = false
                    }
                })
                .padding(.bottom, 60)
            }
            
            Section(header: Text("Settings")) {
                
                MenuRowView(title: showCompleted ? "Hide Done" : "Show Done", iconName: showCompleted ? "eye.slash" : "eye", action: {
                    showCompleted.toggle()
                    withAnimation {
                        showMenu = false
                    }
                })
                .padding(.bottom, 60)
            }
            
            Spacer()
        }
        .padding(.top, 80)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .foregroundColor(.gray)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(showMenu: .constant(true),
                 showCompleted: .constant(true),
                 selection: .constant("None"))
            .previewLayout(.fixed(width: 180, height: 720))
    }
}

//
//  ChecklistHeader.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/22/21.
//

import SwiftUI

struct ChecklistHeader: View {
    var body: some View {
        ZStack(alignment: .top, content: {
            Image("truck-rv").resizable().aspectRatio(contentMode: .fit)
            Text("RV Checklist")
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 30)
        })
    }
}

struct ChecklistHeader_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistHeader()
            .previewLayout(.fixed(width: 300, height: 210))
            .previewDisplayName("Header")
    }
}

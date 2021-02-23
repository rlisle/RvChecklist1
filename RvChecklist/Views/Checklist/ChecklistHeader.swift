//
//  ChecklistHeader.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/22/21.
//

import SwiftUI

struct ChecklistHeader: View {
    var body: some View {
        ZStack(alignment: .topLeading, content: {
            Image("truck-rv").resizable()
                .aspectRatio(contentMode: .fit)
            Text("RV Checklist")
                .foregroundColor(.white)
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.top, 32.0)
                .padding(.leading, 12)
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

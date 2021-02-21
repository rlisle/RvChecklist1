//
//  Checkmark.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/21/21.
//

import SwiftUI

struct Checkmark: View {
    
    @Binding var isDone: Bool
    
    var body: some View {
        Button(action: {
            isDone.toggle()
        }) {
            Image(systemName: isDone ? "checkmark.square" : "square")
                .contentShape(Rectangle())
        }
    }
}

struct Checkmark_Previews: PreviewProvider {
    static var previews: some View {
        Checkmark(isDone: .constant(true))
    }
}

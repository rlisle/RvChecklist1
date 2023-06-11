//
//  Checkmark.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/21/21.
//

import SwiftUI

struct Checkmark: View {
    
    let isDone: Bool
    let action: () -> Void  // performs toggle action
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: isDone ? "checkmark.square" : "square")
                .contentShape(Rectangle())
                .onTapGesture {
                    action()
                }
        }
    }
}

//struct Checkmark_Previews: PreviewProvider {
//    static var previews: some View {
//        Checkmark(isDone: .constant(true)) {
//            print("check")
//        }
//        .previewLayout(.fixed(width: 40, height: 40))
//        .previewDisplayName("Checkmark")
//    }
//}

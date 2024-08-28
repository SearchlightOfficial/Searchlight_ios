//
//  Buttons.swift
//  searchlight_ios
//
//  Created by 김성빈 on 6/10/24.
//

import SwiftUI

enum ButtonType {
    case Primary
    case Secondary
}

struct BasicButton: View {
    let label: String
    var variant: ButtonType = ButtonType.Primary
    var important: Bool = false
    var action: (() -> Void)?
    var icon: ImageResource?
    
    var body: some View {
        Button(action: (action ?? {
            print("Button Clicked")
        }), label: {
            HStack (spacing: 8, content: {
                Typography(text: label, color: variant == ButtonType.Primary ? Color.Grayscale._70 : important ? .Colors.red : .Grayscale._20, fontType: .HeadLine)
                
                if icon != nil {
                    Image(icon!)
                }
            })
            .padding(.vertical, 16.0)
            .frame(maxWidth: .infinity)
            .background(variant == ButtonType.Primary ? Color.Colors.green : .Grayscale._60)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(variant == ButtonType.Primary ? Color.Colors.green : .Grayscale._50, lineWidth: 1)
            )
            .cornerRadius(12)
            .contentShape(Rectangle())
        })
    }
}

#Preview {
    BasicButton(label: "다음", icon: .Icons.arrowForward)
    BasicButton(label: "다음", variant: .Secondary, icon: .Icons.arrowForward)
    BasicButton(label: "다음", variant: .Secondary, important: true, icon: .Icons.arrowForward)
}

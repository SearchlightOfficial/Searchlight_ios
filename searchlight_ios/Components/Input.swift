//
//  Input.swift
//  searchlight_ios
//
//  Created by 김성빈 on 6/11/24.
//

import SwiftUI

extension View {
    func placeholder(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Typography
    ) -> some View {
        ZStack(alignment: alignment, content: {
            if shouldShow {placeholder()}
            self
        })
    }
}

struct Input: View {
    @Binding var text: String
    @Binding var isError: Bool
    let label: String
    let placholder: String
    var action: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Typography(text: label, color: isError ? Color.Colors.red : .Grayscale._30, fontType: .Caption)
                .padding(.horizontal, 8)

            TextField("", text: $text)
                .fontModifier(.Body, .Grayscale._10)
                .placeholder(when: text.isEmpty) {
                    Typography(text: placholder, color: .Grayscale._40, fontType: .Body)
                }
                .onSubmit {(action ?? {print("Input Submited: " + text)})()}
                .padding(16)
                .frame(maxWidth: .infinity, maxHeight: 56, alignment: .center)
                .background(Color.Grayscale._70)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(isError ? Color.Colors.red : Color.Grayscale._50, lineWidth: 1)
                )
                .background(Color.Grayscale._70)
                .cornerRadius(12)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12.0)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var phoneNumber = ""
        @State var isInputError = false
        
        let regex = "^[0-9]{3}[0-9]{4}[0-9]{4}$"
        
        func action() {
            isInputError = (!validateByRegex(phoneNumber, regex) && phoneNumber.isEmpty)
            if isInputError {return}
            
            print("success")
            isInputError = false
        }
        
        var body: some View {
            VStack {
                Input(text: $phoneNumber, isError: $isInputError, label: "전화번호", placholder: "01012341234", action: action)
            }
        }
    }
    
    return PreviewWrapper()
}

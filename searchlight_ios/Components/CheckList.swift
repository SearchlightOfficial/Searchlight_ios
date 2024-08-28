//
//  CheckList.swift
//  searchlight_ios
//
//  Created by 김성빈 on 8/24/24.
//

import SwiftUI

struct CheckList: View {
    @Binding var selected: Array<String>
    let options: Array<String>
    let label: String
    var action: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Typography(text: label, color: .Grayscale._30, fontType: .Caption)
                .padding(.horizontal, 8)
            
            VStack(spacing: 0) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        if selected.contains(option) { selected = selected.filter { $0 != option } }
                        else { selected = selected + [option] }
                        
                        (action ?? {print("\(option) selected")})()
                    }) {
                        HStack(spacing: 4) {
                            Image(selected.contains(option) ? .Icons.checkOn : .Icons.check)
                            
                            Typography(text: option, color: selected.contains(option) ? .Grayscale._10 : .Grayscale._40, fontType: .HeadLine)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                }
            }
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.Grayscale._70)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(Color.Grayscale._50, lineWidth: 1)
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
        @State var emergency: Array<String> = []
        var options: Array<String> = ["일반", "코호트 격리", "음압격리", "일반격리", "외상소생실", "소아", "소아음압격리", "소아일반격리"]
        
        var body: some View {
            CheckList(selected: $emergency, options: options, label: "응급실 종류")
        }
    }
    
    return PreviewWrapper()
}

//
//  Header.swift
//  searchlight_ios
//
//  Created by 김성빈 on 7/10/24.
//

import SwiftUI

struct Header: View {
    var prevClick: (() -> Void)?
    var isSettingEnable: Bool = true

    var body: some View {
        HStack {
            Button(action: (prevClick ?? {
                print("Button Clicked")
            }), label: {
                Image(.Icons.arrowBackward)
            })
            .padding(10)
                     
            Spacer()
            
            if isSettingEnable {
                Button(action: {}, label: {
                    Image(.Icons.settings)
                })
                .padding(10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)
    }
}

#Preview {
    Header()
    Header(isSettingEnable: false)
}

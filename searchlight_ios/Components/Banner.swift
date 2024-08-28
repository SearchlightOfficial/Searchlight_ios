//
//  Banner.swift
//  searchlight_ios
//
//  Created by 김성빈 on 7/29/24.
//

import SwiftUI

struct Banner: View {
    var text: String
    var content: AnyView
        
    init(text: String, @ViewBuilder content: () -> some View = { EmptyView() }) {
        self.text = text
        self.content = AnyView(content())
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Typography(text: text, color: .Grayscale._10, fontType: .LargeTitle)
            
            content
        }
        .padding(.horizontal, 20)
        .padding(.top, 48)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack {
        Banner(text: "안녕하세요,\n환자 정보를 입력해주세요.")
        
        Banner(text: "안녕하세요,\n환자 정보를 입력해주세요.") {
            Text("추가된 콘텐츠")
        }
    }
}

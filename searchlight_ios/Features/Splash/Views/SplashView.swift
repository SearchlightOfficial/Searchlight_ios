//
//  SplashView.swift
//  searchlight_ios
//
//  Created by 김성빈 on 6/11/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image(.logoText)
            .resizable()
            .scaledToFit()
            .frame(height: 36)
    }
}

#Preview {
    SplashView()
}

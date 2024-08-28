//
//  ContentView.swift
//  searchlight_ios
//
//  Created by 김성빈 on 6/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showMainView = false
    @State private var isLogin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.Grayscale._60.ignoresSafeArea()
                
                content
            }
        }
    }
    
    private var content: some View {
        Group {
            if isLogin {
                PatientView()
            } else {
                OnboardingView(isLogined: $isLogin)
            }
        }
    }
}

#Preview {
    ContentView()
}

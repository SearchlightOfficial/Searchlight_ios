//
//  EntryView.swift
//  searchlight_ios
//
//  Created by 김성빈 on 6/10/24.
//
import SwiftUI

struct OnboardingView: View {
    @Binding var isLogined: Bool
    @ObservedObject var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack(spacing: 40, content: {
            Image(.logoText)
                .resizable()
                .scaledToFit()
                .frame(height: 36)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Input(text: $viewModel.carNumber, isError: $viewModel.isInputError, label: "차량번호", placholder: "01가 1234", action: viewModel.registerCarNumber)
                
                Typography(text: "차량번호는 설정에서 변경할 수 있습니다.", color: .Grayscale._20, fontType: .Caption)
                    .padding(8)
            })
            
            BasicButton(label: "등록", action: {
                viewModel.registerCarNumber()
                self.isLogined = true
            }, icon: .Icons.arrowForward)
        })
        .padding(.horizontal, 20.0)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var isLogined: Bool = false
        
        var body: some View {
            OnboardingView(isLogined: $isLogined)
        }
    }
    
    return PreviewWrapper()
}

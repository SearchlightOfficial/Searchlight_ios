//
//  LoadingView.swift
//  searchlight_ios
//
//  Created by 김성빈 on 8/27/24.
//

import SwiftUI

struct LoadingView: View {
    @ObservedObject var patientViewModel = PatientViewModel()
    
    var body: some View {
        Header(prevClick: {}, isSettingEnable: false)
        
        VStack(spacing: 24) {
            Image(.searching)
            
            Typography(text: "주변 병원을 빠르게 찾고 있습니다...", color: .Grayscale._20, fontType: .Body)
            
            VStack(spacing: 16) {
                HStack() {
                    Typography(text: "환자 추정 나이", color: .Grayscale._20, fontType: .Body)
                    Spacer()
                    Typography(text: patientViewModel.age + "세", color: .Grayscale._10, fontType: .HeadLine)
                }
                .frame(maxWidth: .infinity)
                
                HStack() {
                    Typography(text: "환자 성별", color: .Grayscale._20, fontType: .Body)
                    Spacer()
                    Typography(text: patientViewModel.gender, color: .Grayscale._10, fontType: .HeadLine)
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    Typography(text: "응급실 종류", color: .Grayscale._20, fontType: .Body)
                    Spacer()
                    Typography(text: patientViewModel.emergency.count > 2 ? "\(patientViewModel.emergency.prefix(2).joined(separator: ",")) 외 \(patientViewModel.emergency.count - 2)": patientViewModel.emergency.joined(separator: ","), color: .Grayscale._10, fontType: .HeadLine)
                }.frame(maxWidth: .infinity)
                
                HStack() {
                    Typography(text: "KTAS", color: .Grayscale._20, fontType: .Body)
                    Spacer()
                    Typography(text: patientViewModel.KTAS, color: .Grayscale._10, fontType: .HeadLine)
                }
                .frame(maxWidth: .infinity)
            }
                .padding(16)
                .cornerRadius(12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
    }
}

#Preview {
    LoadingView()
}


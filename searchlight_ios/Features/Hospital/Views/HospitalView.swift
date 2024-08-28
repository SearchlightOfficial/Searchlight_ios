//
//  HospitalView.swift
//  searchlight_ios
//
//  Created by 김성빈 on 8/27/24.
//

import SwiftUI

struct HospitalItem: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.Grayscale._70)
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.5)
            .stroke(Color.Grayscale._50, lineWidth: 1)
        )
    }
}

struct HospitalView: View {
    var body: some View {
        Header(prevClick: {}, isSettingEnable: false)
        
        Banner(text: "병원 세 곳중\n적합한 곳을 선택해주세요")
        
        VStack(spacing: 8) {
            HospitalItem()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

#Preview {
    HospitalView()
}

//
//  OnboardingViewModel.swift
//  searchlight_ios
//
//  Created by 김성빈 on 6/10/24.
//
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var carNumber: String = UserDefaults.standard.string(forKey: "carNumber") ?? ""
    @Published var isInputError: Bool = false
    
    private let carNumberRegex: String = "^([0-9]{2,3}[가-힣]{1}\\s*[0-9]{4})$"
    
    func registerCarNumber() {
        isInputError = (!validateByRegex(carNumber, carNumberRegex) || carNumber.isEmpty)
        if isInputError {return}
        
        UserDefaults.standard.set(carNumber, forKey: "carNumber")
        isInputError = false
    }
}

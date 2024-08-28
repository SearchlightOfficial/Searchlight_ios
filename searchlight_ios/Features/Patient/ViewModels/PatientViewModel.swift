//
//  PatientViewModel.swift
//  searchlight_ios
//
//  Created by 김성빈 on 7/29/24.
//

import SwiftUI
import Alamofire

class PatientViewModel: ObservableObject {
    private var locationManager = LocationManager()
    
    @Published var isHospitalViewActive: Bool = false
    
    @Published var location: String = ""
    
    var lat: String = ""
    var lon: String = ""

    @Published var step: Int8 = 0
    
    @Published var age: String = ""
    @Published var isAgeError: Bool = false
    
    @Published var gender: String = ""
    
    @Published var emergency: Array<String> = []
    
    @Published var KTAS: String = ""
    @Published var isKTASError: Bool = false
    
    @Published var symptoms: String = ""
    @Published var isSymptomsError: Bool = false
    
    @Published var isModalPresented: Bool = false

    func getLocation() {
        locationManager.checkLocationAuthorization()
        
        location = String(format: "%f", locationManager.lastKnownLocation?.latitude ?? 0)
        lat = String(format: "%f", locationManager.lastKnownLocation?.latitude ?? 0)
        lon = String(format: "%f", locationManager.lastKnownLocation?.longitude ?? 0)
    }
    
    private let ageRegex: String = "^[0-9]+$"
    
    func prevStep() {
        withAnimation {
            if step != 0 {
                step -= 1
            }
        }
    }
    
    func closeModal() {
        if isModalPresented {
            isModalPresented = false
        }
    }
    
    func nextStep() {
        withAnimation {
            switch step {
            case 0:
                isAgeError = (!validateByRegex(age, ageRegex)) || age.isEmpty
                if isAgeError {return}
                
                step += 1
                break
            case 1:
                if (gender == "") {return}
                
                step += 1
                break
            case 2:
                if (emergency.count == 0) {return}
                
                step += 1
                break
            case 3:
                isKTASError = KTAS.isEmpty
                if isKTASError {return}
                
                step += 1
                break
            case 4:
                isSymptomsError = symptoms.isEmpty
                if isSymptomsError {return}
                
                isModalPresented = true
                break
            default:
                print("Step Overflow")
                break
            }
        }
    }
    
    func fetchHospital() {
        let url = Network.baseURL + "/hospital/fetch"
        
        let params: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "rltmEmerCds": emergency.map({ item in
                return [
                    "일반": "O001",
                    "코호트 격리": "O059",
                    "음압격리": "O003",
                    "일반격리": "O004",
                    "외상소생실": "O060",
                    "소아": "O002",
                    "소아음압격리": "O048",
                    "소아일반격리": "O049"
                ][item]
            })
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default
        )
        .validate()
        .responseDecodable(of: [Hospital].self) { response in
            switch response.result {
            case .success(let value):
                print("DEBUG \(value)")
            case .failure(let value):
                print(value.localizedDescription)
                print("DEBUG \(value)")
            }
        }
    }
}

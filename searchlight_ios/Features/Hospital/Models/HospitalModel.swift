//
//  HospitalModel.swift
//  searchlight_ios
//
//  Created by 김성빈 on 8/28/24.
//

import Foundation

struct Hospital: Codable {
    let name: String
    let distance: String
    let address: String
    let beds: [Bed]
    let emergencyMessage: [String]
    let impossibleMessage: [String]
}

struct Bed: Codable {
    let type: String
    let count: String
}

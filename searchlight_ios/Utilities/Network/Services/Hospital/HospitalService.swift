//
//  HospitalService.swift
//  searchlight_ios
//
//  Created by 김성빈 on 8/28/24.
//

import Foundation
import Alamofire

enum HospitalService {
    case fetch(lat: String, lon: String, rltmEmerCds: Array<String>)
}

extension HospitalService {
    var path: String {
        switch self {
        case .fetch:
            return "/hospital/fetch"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetch:
            return .post
        }
    }
    
    var parameter: Parameters {
        switch self {
        case let .fetch(lat, lon, rltmEmerCds):
            return [
                "lat": lat,
                "lon": lon,
                "rltmEmerCds": rltmEmerCds
            ]
        }
    }
}

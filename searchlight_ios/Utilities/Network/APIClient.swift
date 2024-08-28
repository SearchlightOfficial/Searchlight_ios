//
//  APIClient.swift
//  searchlight_ios
//
//  Created by 김성빈 on 8/28/24.
//

import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient()
    
    func request<T: Decodable>(_ url: URL, _ method: HTTPMethod = .get, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, encoding: URLEncoding.default, headers: [
            "Content-Type": "application/json"
        ]).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

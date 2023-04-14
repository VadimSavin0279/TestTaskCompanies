//
//  APIManager.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import Foundation
import Alamofire

enum ResponseType: Int {
    case completion = 200
    case errorAuth = 401
    case errorMessage = 400
    case errorInternal = 500
}

enum Result<T: Codable> {
    case success(T)
    case failure(String)
}

class APIManager {
    func sendRequest<T, U>(with target: T,
                              decodeType: U.Type,
                              completion: @escaping (Result<U>) -> ())
    where T: Provider, U: Decodable {
        guard let url = URL(string: target.baseURL + target.path) else { return }
        AF.request(url,
                   method: target.method,
                   parameters: target.params,
                   encoding: JSONEncoding.default,
                   headers: target.headers).response { [self] response in
            requestProcess(response: response, completion: completion)
        }
    }
    
    private func requestProcess<U>(response: AFDataResponse<Data?>, completion: (Result<U>) -> ()) where U: Decodable {
        switch response.result {
        case .success(let data):
            do {
                guard let data = data,
                        let code = response.response?.statusCode,
                        let responseType = ResponseType(rawValue: code) else { return }
                
                switch responseType {
                case .completion:
                    let json = try JSONDecoder().decode(U.self, from: data)
                    completion(.success(json))
                case .errorAuth:
                    completion(.failure("Ошибка авторизации"))
                case .errorMessage:
                    let json = try JSONDecoder().decode(MyError.self, from: data)
                    completion(.failure(json.message))
                case .errorInternal:
                    completion(.failure("Все упало"))
                    
                }
            } catch {
                print(error)
            }
        case .failure(let error):
            print(error)
        }
    }
}

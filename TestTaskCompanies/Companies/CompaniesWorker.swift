//
//  CompaniesWorker.swift
//  TestTaskCompanies
//
//  Created by 123 on 13.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Alamofire

class CompaniesService {
    let apiManager = APIManager()
    func fetchCompany(completion: @escaping ([Card]) -> (),
                       completionForError: @escaping (String) -> ()) {
        apiManager.sendRequest(with: CompaniesProvider.getAllCompanies, decodeType: [Card].self) { response in
            switch response {
            case .success(let result):
                completion(result)
            case .failure(let errorMessage):
                completionForError(errorMessage)
            }
        }
    }
    
}

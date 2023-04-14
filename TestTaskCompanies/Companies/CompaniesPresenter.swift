//
//  CompaniesPresenter.swift
//  TestTaskCompanies
//
//  Created by 123 on 13.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CompaniesPresentationLogic {
    func presentData(response: Companies.Model.Response.ResponseType)
}

class CompaniesPresenter: CompaniesPresentationLogic {
    weak var viewController: CompaniesDisplayLogic?
    
    func presentData(response: Companies.Model.Response.ResponseType) {
        switch response {
        case .some:
            break
        case .showAlert(let string):
            viewController?.displayData(viewModel: .showAlert(string))
        case .presentNewCompanies(let newCompanies):
            viewController?.displayData(viewModel: .displayNewCompanies(newCompanies))
        case .setLoadingState(let state):
            viewController?.displayData(viewModel: .displayLoader(state))
        case .processInfo(let id, let type):
            var nameOfButton = ""
            switch type {
            case .delete:
                nameOfButton = "Кнопка: удалить"
            case .view:
                nameOfButton = "Кнопка: посмотреть"
            case .more:
                nameOfButton = "Кнопка: подробнее"
            }
            let messsage = "ID компании: " + id
            viewController?.displayData(viewModel: .showAllertWithInfo(nameOfButton, messsage))
        case .stopRequests:
            viewController?.displayData(viewModel: .stopRequests)
        }
    }
    
}

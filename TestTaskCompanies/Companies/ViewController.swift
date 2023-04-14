//
//  ViewController.swift
//  TestTaskCompanies
//
//  Created by 123 on 13.04.2023.
//

import UIKit

protocol CompaniesDisplayLogic: AnyObject {
    func displayData(viewModel: Companies.Model.ViewModel.ViewModelData)
}

class ViewController: UIViewController {
    
    var interactor: CompaniesBusinessLogic?
    var router: (NSObjectProtocol & CompaniesRoutingLogic)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBOutlet weak var tableView: UITableView!
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.tintColor
        label.text = "Управление картами"
        label.font = .systemFont(ofSize: 22)
        return label
    }()
    
    let loaderView: UIView = {
        guard let view = UINib(nibName: "CustomFooterView", bundle: nil).instantiate(withOwner: nil).first as? UIView else {
            return UIView()
        }
        return view
    }()
    
    var model = CompaniesModel()
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                tableView.tableFooterView?.isHidden = false
            } else {
                tableView.tableFooterView?.isHidden = true
            }
        }
    }
    var requestsIsStopped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        interactor?.makeRequest(request: .getCompanies)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupPreloader()
    }
    
    private func setup() {
        let viewController        = self
        let interactor            = CompaniesInteractor()
        let presenter             = CompaniesPresenter()
        let router                = CompaniesRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    private func setupScreen() {
        tableView.register(UINib(nibName: "\(CustomCell.self)", bundle: nil), forCellReuseIdentifier: CustomCell.description())
        tableView.backgroundColor = UIColor.clear
        navigationItem.titleView = titleLabel
    }
    
    private func setupPreloader() {
        loaderView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 35000/view.bounds.width)
        tableView.tableFooterView = loaderView
    }
    
    private func showAlert(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.description(), for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: model.companies[indexPath.row], of: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.companies.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == model.companies.count - 1 && !isLoading && !requestsIsStopped {
            interactor?.makeRequest(request: .getCompanies)
        }
    }
}

extension ViewController: CompaniesDisplayLogic {
    func displayData(viewModel: Companies.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .some:
            break
        case .showAlert(let string):
            showAlert(message: string, title: "Error!")
        case .displayNewCompanies(let newCompanies):
            model.companies.append(contentsOf: newCompanies)
            tableView.reloadData()
        case .displayLoader(let state):
            isLoading = state
        case .showAllertWithInfo(let title, let message):
            showAlert(message: message, title: title)
        case .stopRequests:
            isLoading = false
            requestsIsStopped = true
        }
    }
}


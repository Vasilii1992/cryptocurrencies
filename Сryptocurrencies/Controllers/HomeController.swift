//
//  ViewController.swift
//  Сryptocurrencies
//
//  Created by Василий Тихонов on 15.07.2024.
//

import UIKit

class HomeController: UIViewController {
    
    private let viewModel: HomeControllerViewModel
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifire)
        
        return table
    }()
    
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.viewModel.onCoinsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.onErrorMessage = { [weak self] error in
         
            let alert = UIAlertController(title: nil, message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            
            DispatchQueue.main.async {
                switch error {
                    
                case .serverError(let serverError):
                    alert.title = "Server Error \(serverError.errorCode)"
                    alert.message = serverError.errorMessage
                case .unknown(let string):
                    alert.title = "Error Fetching Coins"
                    alert.message = string
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                self?.present(alert,animated: true)
            }
            
        }
        
    }

    private func setupUI () {
        navigationItem.title = "Сrypto"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        
        ])
        
        
    }
    
}

extension HomeController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifire, for: indexPath) as? CoinCell else {
            return UITableViewCell()
        }
        
        let coin = viewModel.coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // чтоб при выборе ячейки она загоралась, а потом переставала
        tableView.deselectRow(at: indexPath, animated: true)
        
        let coin = viewModel.coins[indexPath.row]
        let viewModel = ViewCryptoControllerViewModel(coin)
        let vc = ViewCryptoController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

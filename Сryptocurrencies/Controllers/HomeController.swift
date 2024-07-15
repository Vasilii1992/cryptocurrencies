//
//  ViewController.swift
//  Сryptocurrencies
//
//  Created by Василий Тихонов on 15.07.2024.
//

import UIKit

class HomeController: UIViewController {
    
   private let coins: [Coin] = Coin.getMockArray()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifire)
        
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifire, for: indexPath) as? CoinCell else {
            return UITableViewCell()
        }
        
        let coin = coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // чтоб при выборе ячейки она загоралась, а потом переставала
        tableView.deselectRow(at: indexPath, animated: true)
        
        let coin = coins[indexPath.row]
        let viewModel = ViewCryptoControllerViewModel(coin)
        let vc = ViewCryptoController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

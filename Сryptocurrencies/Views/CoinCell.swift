//
//  CoinCell.swift
//  Сryptocurrencies
//
//  Created by Василий Тихонов on 15.07.2024.
//

import UIKit

class CoinCell: UITableViewCell {
    static let identifire = "CoinCell"
    
    
    private(set) var coin: Coin!
    
    private let coinLogo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "questionmark")
        image.tintColor = .black
        return image
    }()
    
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22,weight: .semibold)
        label.text = "Error"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coin: Coin) {
        self.coin = coin
        coinName.text = coin.name
        DispatchQueue.global().async { [weak self] in
            
            let request = URLRequest(url: coin.logoURL!,cachePolicy: .useProtocolCachePolicy)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        
                        self?.coinLogo.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coinName.text = nil
        coinLogo.image = nil
    }
    
    private func setupUI() {
        contentView.addSubview(coinLogo)
        contentView.addSubview(coinName)
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        coinName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.75), //
            coinLogo.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.75),
            
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor,constant: 16),
            coinName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
        
    }

}

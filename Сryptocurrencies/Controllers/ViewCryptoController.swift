//
//  ViewCryptoController.swift
//  Сryptocurrencies
//
//  Created by Василий Тихонов on 15.07.2024.
//

import UIKit

class ViewCryptoController: UIViewController {
    
    let viewModel: ViewCryptoControllerViewModel
    
    private let scrollView: UIScrollView = {
       let scroll = UIScrollView()
        return scroll
        
    }()
    
    private let contentView: UIView = {
       let view = UIView()
        return view
        
    }()
    
    private let coinLogo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "questionmark")
        image.tintColor = .label
        return image
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20,weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20,weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20,weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let maxSupplyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20,weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [rankLabel, priceLabel, marketCapLabel, maxSupplyLabel])
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.distribution = .fill
        vStack.alignment = .center
        
        return vStack
    }()
    
    init(_ viewModel: ViewCryptoControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.coin.name
        navigationController?.navigationBar.topItem?.backBarButtonItem =
        UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        
            // description переводит в string
        rankLabel.text = viewModel.rankLabel
        priceLabel.text = viewModel.priceLabel
        marketCapLabel.text = viewModel.marketCapLabel
        maxSupplyLabel.text = viewModel.maxSupplyLabel
        

        viewModel.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.coinLogo.image = image

            }
        }
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(coinLogo)
        contentView.addSubview(vStack)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
//        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
//        height.priority = UILayoutPriority(1)
//        height.isActive = true

        
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
//            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
//            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),


            coinLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            coinLogo.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            coinLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coinLogo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coinLogo.heightAnchor.constraint(equalToConstant: 200),

            
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: coinLogo.bottomAnchor,constant: 20),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }
}

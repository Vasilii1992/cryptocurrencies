//
//  ViewCryptoControllerViewModel.swift
//  Сryptocurrencies
//
//  Created by Василий Тихонов on 15.07.2024.
//

import Foundation
import UIKit

class ViewCryptoControllerViewModel {
    
    let coin: Coin
    
    init(_ coin: Coin) {
        self.coin = coin
    }
    
    var rankLabel: String {
        return "Rank: \(coin.cmc_rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(coin.quote.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(coin.quote.CAD.market_cap)"
    }
    
    var maxSupplyLabel: String {
        if let maxSupply = coin.max_supply {
            return "Max Supply: \(maxSupply)"
        } else {
            return "Don't have some information about that."
        }
    }
        
     func loadImage(completion: @escaping (UIImage?) -> Void) {
        let url = coin.logoURL
        let request = URLRequest(url: url!,cachePolicy: .useProtocolCachePolicy)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                   print("Удалось получить изображение")
                completion(image)
                    
            } else {
                print("Нет изображения")
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    
    
}

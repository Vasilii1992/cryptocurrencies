//
//  Endpoint.swift
//  Сryptocurrencies
//
//  Created by Василий Тихонов on 24.07.2024.
//

import Foundation

enum Endpoint {
    // мне нужно эта страка как значение по умолчанию,если я не ввожу свои данные, то просто вызываю функцию с скобками и получаю этот урл
    case fetchCoins(url:String = "/v1/cryptocurrency/listings/latest")
    
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        request.addValues(for: self)
        
        return request
    }
    
    
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchCoins(let url):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchCoins:
            return [
            URLQueryItem(name: "limit", value: "150"),
            URLQueryItem(name: "sort", value: "market_cap"),
            URLQueryItem(name: "convert", value: "CAD"),
            URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply"),



            
            ]
        }
    }
    
    
    
    private var httpMethod: String {
        
        switch self {
        case .fetchCoins(let url):
            return HTTP.Method.get.rawValue
        }
    }
    
    // если бы я отправлял данные
    private var httpBody: Data? {
        switch self {
        case .fetchCoins:
            return nil
//            return try? JSONEncoder().encode(Coin(id: 1,
//                                                  name: "bitcoin",
//                                                  maxSupply: 2,
//                                                  rank: 2,
//                                                  pricingData: PricingData(CAD: CAD(price: 200, market_cap: 1))))
        }
    }
}

extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchCoins:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue,
                          forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            self.setValue(Constants.API_KEY,
                          forHTTPHeaderField: HTTP.Headers.Key.apiKey.rawValue)
        }
    }
}

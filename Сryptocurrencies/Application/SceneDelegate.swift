//
//  SceneDelegate.swift
//  Сryptocurrencies
//
//  Created by Василий Тихонов on 15.07.2024.
//

import UIKit
import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController(rootViewController: HomeController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        print("DEBUG PRINT:", SDImageCache.shared.diskCache.totalSize())
        
        SDImageCache.shared.config.maxDiskSize = 1_000_000 * 20
    }
}


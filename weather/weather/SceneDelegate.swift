//
//  SceneDelegate.swift
//  weather
//
//  Created by Dmitrii Imaev on 15.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let selectGradeTVC = CitysTableViewController()
        let navigationController = UINavigationController(rootViewController: selectGradeTVC)
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
    }
}


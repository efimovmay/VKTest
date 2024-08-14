//
//  SceneDelegate.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		
		let navigationController = UINavigationController()
		
		let keychain = KeychainService()
		let authService = AuthService(keychainService: keychain)
		
		if authService.getToken() == nil {
			let rootViewController = LoginAssembly.makeModule(
				navigationController: navigationController,
				authService: authService
			)
			navigationController.pushViewController(rootViewController, animated: false)

		} else {
			let rootViewController = GalleryAssembly.makeModule(
				navigationController: navigationController,
				authService: authService
			)
			navigationController.pushViewController(rootViewController, animated: false)
		}

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}

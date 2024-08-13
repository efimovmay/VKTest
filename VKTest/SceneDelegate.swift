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
		
		let navController = UINavigationController()
		
		if let account = UserDefaults.standard.string(forKey: AuthConst.account) {
			let keychain = KeychainService(account: account)
			let rootViewController = GalleryAssembly.makeModule(navigationController: navController, keychain: keychain)
			navController.pushViewController(rootViewController, animated: false)
		} else {
			let rootViewController = LoginAssembly.makeModule(navigationController: navController)
			navController.pushViewController(rootViewController, animated: false)
		}

		window?.rootViewController = navController
		window?.makeKeyAndVisible()
	}
}

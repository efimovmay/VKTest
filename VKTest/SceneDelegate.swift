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
		let rootViewController = makeGallery(navigationController: navController)
	//	let rootViewController = LoginAssembly.makeModule(navigationController: navController)
		navController.pushViewController(rootViewController, animated: false)
		
		window?.rootViewController = navController
		window?.makeKeyAndVisible()
	}
	
	func makeGallery(navigationController: UINavigationController) -> UIViewController {
		let keychainService = KeychainService(account: "381340939")
		let networkService = NetworkService(baseUrl: NetworkEndpoints.baseURL)
		let router = GalleryRouter(navigationController: navigationController)
		let presenter = GalleryPresenter(
			router: router,
			network: networkService,
			keychain: keychainService
		)
		let viewController = GalleryViewController(presenter: presenter)
		
		return viewController
	}
}

//
//  GalleryAssembly.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import UIKit

enum GalleryAssembly {
	
	static func makeModule(navigationController: UINavigationController, userId: String, token: String) -> UIViewController {
		let keychainService = KeychainService(account: userId)
		keychainService.saveToken(token: token)
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

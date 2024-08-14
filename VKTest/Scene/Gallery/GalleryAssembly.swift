//
//  GalleryAssembly.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import UIKit

enum GalleryAssembly {
	
	static func makeModule(navigationController: UINavigationController, authService: IAuthService) -> UIViewController {
		let networkService = NetworkService(baseUrl: NetworkEndpoints.baseURL)
		let router = GalleryRouter(navigationController: navigationController, authService: authService)
		let presenter = GalleryPresenter(
			router: router,
			network: networkService,
			authService: authService
		)
		let viewController = GalleryViewController(presenter: presenter)
		
		return viewController
	}
}

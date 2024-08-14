//
//  AuthAssembly.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import UIKit

enum AuthAssembly {
	
	static func makeModule(navigationController: UINavigationController, authService: IAuthService) -> UIViewController {
		let router = AuthRouter(navigationController: navigationController, authService: authService)
		let presenter = AuthPresenter(router: router, authService: authService)
		let viewController = AuthViewController(presenter: presenter)
		
		return viewController
	}
}

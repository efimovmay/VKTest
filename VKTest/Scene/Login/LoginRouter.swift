//
//  LoginRouter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit

protocol ILoginRouter {
	func routeToAuthView()
}

final class LoginRouter: ILoginRouter {
	
	private let navigationController: UINavigationController
	private let authService: IAuthService

	init(navigationController: UINavigationController, authService: IAuthService) {
		self.navigationController = navigationController
		self.authService = authService
	}
	
	func routeToAuthView() {
		navigationController.present(
			AuthAssembly.makeModule(navigationController: navigationController, authService: authService), animated: true
		)
	}
}

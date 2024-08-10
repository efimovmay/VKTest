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
//	private let network: INetworkService

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func routeToAuthView() {
		let router = AuthRouter(navigationController: navigationController)
		let presenter = AuthPresenter(router: router)
		let viewController = AuthViewController(presenter: presenter)
		navigationController.present(viewController, animated: true)
	}
}

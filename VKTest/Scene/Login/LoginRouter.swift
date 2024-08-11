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

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func routeToAuthView() {
		navigationController.present(
			AuthAssembly.makeModule(navigationController: navigationController), animated: true
		)
	}
}

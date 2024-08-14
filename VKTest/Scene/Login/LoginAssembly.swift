//
//  LoginAssembly.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit

enum LoginAssembly {

	static func makeModule(navigationController: UINavigationController, authService: IAuthService) -> UIViewController {
		let router = LoginRouter(navigationController: navigationController, authService: authService)
		let presenter = LoginPresenter(router: router)
		let viewController = LoginViewController(presenter: presenter)
		
		return viewController
	}
}

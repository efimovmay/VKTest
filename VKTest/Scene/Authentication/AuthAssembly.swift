//
//  AuthAssembly.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import UIKit

enum AuthAssembly {
	
	static func makeModule(navigationController: UINavigationController) -> UIViewController {
		let router = AuthRouter(navigationController: navigationController)
		let presenter = AuthPresenter(router: router)
		let viewController = AuthViewController(presenter: presenter)
		
		return viewController
	}
}

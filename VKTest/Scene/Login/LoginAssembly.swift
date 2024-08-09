//
//  LoginAssembly.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit

enum LoginAssembly {
	
	struct Dependencies {
		let navigationController: UINavigationController
	}
	
	static func makeModule(dependencies: Dependencies) -> UIViewController {
		let router = LoginRouter(navigationController: dependencies.navigationController)
		let presenter = LoginPresenter(router: router)
		let viewController = LoginViewController(presenter: presenter)
		
		return viewController
	}
}

//
//  LoginAssembly.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit

enum LoginAssembly {
	
	struct Dependencies {
//		let network: INetworkService
	}
	
	static func makeModule(dependencies: Dependencies) -> UIViewController {
		let router = LoginRouter()
		let presenter = LoginPresenter(router: router)
		let viewController = LoginViewController(presenter: presenter)
		
		return viewController
	}
}

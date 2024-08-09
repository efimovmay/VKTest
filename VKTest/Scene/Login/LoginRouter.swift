//
//  LoginRouter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit

protocol ILoginRouter {
	func routeToAuthView()
	func routeToGalleryView()
}

final class LoginRouter: ILoginRouter {
	
	private let navigationController: UINavigationController
//	private let network: INetworkService

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func routeToAuthView() {
		navigationController.present(AuthViewController(), animated: true)
	}
	
	func routeToGalleryView() {
		
	}
}

private extension LoginRouter {

}

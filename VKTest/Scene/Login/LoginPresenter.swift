//
//  LoginPresenter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import Foundation

protocol ILoginPresenter {
	func routeToAuthScreen()
}

final class LoginPresenter: ILoginPresenter {
	// MARK: - Dependencies
	
	private weak var view: LoginViewController?
	private let router: ILoginRouter
	
	// MARK: - Initialization
	
	init(router: ILoginRouter) {
		self.router = router
	}
	
	func routeToAuthScreen() {
		router.routeToAuthView()
	}
}

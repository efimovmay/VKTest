//
//  LoginPresenter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import Foundation

protocol ILoginPresenter {

}

final class LoginPresenter: ILoginPresenter {
	// MARK: - Dependencies
	
	private weak var view: ILoginView?
	private let router: ILoginRouter
	
	// MARK: - Initialization
	
	init(router: ILoginRouter) {
		self.router = router
	}
}

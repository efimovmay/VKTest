//
//  LoginRouter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import Foundation

protocol ILoginRouter {
	func routeToAuthView()
	func routeToGalleryView()
}

final class LoginRouter: ILoginRouter {

//	private let network: INetworkService

	init() {
	}
	
	func routeToAuthView() {
	}
	
	func routeToGalleryView() {
		
	}
}

private extension LoginRouter {

}

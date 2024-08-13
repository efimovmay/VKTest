//
//  AuthRouter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 10.08.2024.
//

import UIKit

protocol IAuthRouter {
	func routeToGalleryView(keychain: KeychainService)
	func showAlert(with error: String?)
}

final class AuthRouter: IAuthRouter {
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func routeToGalleryView(keychain: KeychainService) {
		navigationController.dismiss(animated: true)
		let galleryViewController = GalleryAssembly.makeModule(
			navigationController: navigationController,
			keychain: keychain
		)
		navigationController.setViewControllers([galleryViewController], animated: true)
	}
	
	func showAlert(with error: String?) {
		let alert = UIAlertController(
			title: L10n.Common.error.capitalized,
			message: error,
			preferredStyle: UIAlertController.Style.alert
		)
		alert.addAction(UIAlertAction(
			title: L10n.Common.ok,
			style: UIAlertAction.Style.default, handler: nil
		))
		navigationController.present(alert, animated: true, completion: nil)
	}
}

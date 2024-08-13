//
//  GalleryRouter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import UIKit

protocol IGalleryRouter {
	func popToLogin()
	func showPhoto(photoData: GalleryViewModel.Foto)
	func showAlert(with error: String?)
}

final class GalleryRouter: IGalleryRouter {
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func popToLogin() {
		let loginViewController = LoginAssembly.makeModule(navigationController: navigationController)
		navigationController.setViewControllers([loginViewController], animated: true)
	}
	
	func showPhoto(photoData: GalleryViewModel.Foto) {
		let router = PhotoRouter(navigationController: navigationController)
		let presenter = PhotoPresenter(router: router, photoData: photoData)
		let viewController = PhotoViewController(presenter: presenter)
		navigationController.pushViewController(viewController, animated: true)
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

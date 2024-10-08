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
	func showVideo(videoData: GalleryViewModel.Video)
	func showAlert(with error: String?)
}

final class GalleryRouter: IGalleryRouter {
	
	private let navigationController: UINavigationController
	private let authService: IAuthService
	
	init(navigationController: UINavigationController, authService: IAuthService) {
		self.navigationController = navigationController
		self.authService = authService
	}
	
	func popToLogin() {
		let loginViewController = LoginAssembly.makeModule(
			navigationController: navigationController,
			authService: authService
		)
		navigationController.setViewControllers([loginViewController], animated: true)
	}
	
	func showPhoto(photoData: GalleryViewModel.Foto) {
		let viewController = PhotoAssembly.makeModule(navigationController: navigationController, photoData: photoData)
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func showVideo(videoData: GalleryViewModel.Video) {
		let viewController = VideoAssembly.makeModule(navigationController: navigationController, videoData: videoData)
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

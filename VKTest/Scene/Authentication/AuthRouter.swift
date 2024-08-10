//
//  AuthRouter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 10.08.2024.
//

import UIKit

protocol IAuthRouter {
	func routeToGalleryView()
	func closeWindow()
	func showAlert(with error: String)
}

final class AuthRouter: IAuthRouter {

	private let navigationController: UINavigationController
	//	private let network: INetworkService
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func routeToGalleryView() {
		closeWindow()
		navigationController.popViewController(animated: false)
		navigationController.pushViewController(GalleryViewController(), animated: true)
	}
	
	func closeWindow() {
		navigationController.dismiss(animated: true)
	}
	
	func showAlert(with error: String) {
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
	}}

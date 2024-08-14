//
//  VideoRouter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import UIKit

protocol IVideoRouter {
	func showShareMenu(with activityItems: [AnyObject])
	func showAlert(with title: String, and text: String?)
}

final class VideoRouter: IVideoRouter {
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func showShareMenu(with activityItems: [AnyObject]) {
		let shareController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
		shareController.completionWithItemsHandler = { _, success, _, error in
			if success {
				self.showAlert(with: L10n.Common.message, and: L10n.PhotoScreen.sendEnd)
			}
			if let error {
				self.showAlert(with: L10n.Common.error, and: L10n.PhotoScreen.sendError)
			}
		}
		navigationController.present(shareController, animated: true, completion: nil)
	}
	
	func showAlert(with title: String, and text: String?) {
		let alert = UIAlertController(
			title: title,
			message: text,
			preferredStyle: UIAlertController.Style.alert
		)
		alert.addAction(UIAlertAction(
			title: L10n.Common.ok,
			style: UIAlertAction.Style.default, handler: nil
		))
		navigationController.present(alert, animated: true, completion: nil)
	}
}

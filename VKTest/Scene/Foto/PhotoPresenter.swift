//
//  PhotoPresenter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 13.08.2024.
//

import Foundation

protocol IPhotoPresenter: AnyObject {
	func viewIsReady(view: IPhotoView)
	func share(activityItems: [AnyObject])
	func showError(error: String?)
}

final class PhotoPresenter: NSObject, IPhotoPresenter {
	
	private weak var view: IPhotoView?
	private let router: IPhotoRouter
	
	private let photoData: GalleryViewModel.Foto
	private let dateFormatter = DateFormatter()
	
	init(router: IPhotoRouter, photoData: GalleryViewModel.Foto) {
		self.router = router
		self.photoData = photoData
	}
	
	func viewIsReady(view: IPhotoView) {
		self.view = view
		view.render(title: getTitle(), photoURL: URL(string: photoData.urlOrig))
	}
	
	func share(activityItems: [AnyObject]) {
		router.showShareMenu(with: activityItems)
	}
	
	func showError(error: String?) {
		router.showAlert(with: L10n.Common.error, and: error)
	}
}

private extension PhotoPresenter {
	func getTitle() -> String {
		let timeInterval: TimeInterval = TimeInterval(photoData.data)
		let date = Date(timeIntervalSince1970: timeInterval)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM yyyy"
		dateFormatter.locale = Locale(identifier: "ru_RU")
		let formattedDate = dateFormatter.string(from: date)
		
		return formattedDate
	}
}

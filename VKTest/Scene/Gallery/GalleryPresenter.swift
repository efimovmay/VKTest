//
//  GalleryPresenter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import Foundation

protocol IGalleryPresenter {
	func viewIsReady(view: IGalleryView)
}

final class GalleryPresenter: IGalleryPresenter {
	
	private weak var view: IGalleryView?
	private let router: IGalleryRouter
	private let network: INetworkService
	private let keychain: KeychainService
	
	init(router: IGalleryRouter, network: INetworkService, keychain: KeychainService) {
		self.router = router
		self.network = network
		self.keychain = keychain
	}
	
	func viewIsReady(view: IGalleryView) {
		self.view = view
	}

}

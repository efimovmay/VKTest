//
//  GalleryPresenter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import Foundation

protocol IGalleryPresenter {
	func getCountFotos() -> Int
	func fotoDidSelect(at index: Int)
	func viewIsReady(view: IGalleryView)
}

final class GalleryPresenter: IGalleryPresenter {
	
	private weak var view: IGalleryView?
	private let router: IGalleryRouter
	private let network: INetworkService
	private let keychain: KeychainService
	
	private var fotos: [GalleryViewModel.Foto] = .init()
	private var videos: [GalleryViewModel.Video] = .init()
	
	init(router: IGalleryRouter, network: INetworkService, keychain: KeychainService) {
		self.router = router
		self.network = network
		self.keychain = keychain
	}
	
	func viewIsReady(view: IGalleryView) {
		self.view = view
		fetchData()
	}
	
	func logout() {
		keychain.deleteToken()
		router.popToLogin()
	}
}

extension GalleryPresenter {
	func getCountFotos() -> Int {
		fotos.count
	}
	
	func fotoDidSelect(at index: Int) {
		
	}
}

private extension GalleryPresenter {
	func fetchData() {
		guard let token = keychain.getToken() else { return }
		network.fetch(dataType: FotoDTO.self, with: NetworkRequestFotos(token: token)) { [weak self] result in
			switch result {
			case .success(let data):
				self?.parsingFoto(data: data)
			case .failure(let error):
				self?.router.showAlert(with: error.localizedDescription)
			}
		}
	}
	
	func parsingFoto(data: FotoDTO) {
		data.response.items.forEach { item in
			fotos.append(GalleryViewModel.Foto(
				data: item.date,
				urlPrev: item.sizes[4].url,
				urlOrig: item.origPhoto.url
			))
		}
		reloadCollection()
	}
	
	func reloadCollection() {
		DispatchQueue.main.async {
			self.view?.reloadFotoCollection()
		}
	}
}

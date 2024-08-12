//
//  GalleryPresenter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import Foundation

protocol IGalleryPresenter {
	func viewIsReady(view: IGalleryView)
	
	func getCountFotos() -> Int
	func getFoto(at index: Int) -> GalleryViewModel.Foto
	func fotoDidSelect(at index: Int)
	
	func getCountVideo() -> Int
	func getVideo(at index: Int) -> GalleryViewModel.Video
	func videoDidSelect(at index: Int)
	
	func fetchFoto()
	
}

final class GalleryPresenter: IGalleryPresenter {
	
	private weak var view: IGalleryView?
	private let router: IGalleryRouter
	private let network: INetworkService
	private let keychain: KeychainService
	
	private var fotos: [GalleryViewModel.Foto] = .init()
	private var videos: [GalleryViewModel.Video] = .init()
	private var maxCount: Int?
	
	init(router: IGalleryRouter, network: INetworkService, keychain: KeychainService) {
		self.router = router
		self.network = network
		self.keychain = keychain
	}
	
	func viewIsReady(view: IGalleryView) {
		self.view = view
		fetchFoto()
		fetchVideo()
	}
	
	func logout() {
		keychain.deleteToken()
		router.popToLogin()
	}
}

extension GalleryPresenter {
	func getCountFotos() -> Int {
		return fotos.count
	}
	
	func getFoto(at index: Int) -> GalleryViewModel.Foto {
		return fotos[index]
	}
	
	func fotoDidSelect(at index: Int) {
		
	}
	
	func getCountVideo() -> Int {
		return videos.count
	}
	func getVideo(at index: Int) -> GalleryViewModel.Video {
		return videos[index]
	}
	
	func videoDidSelect(at index: Int) {
		
	}
	
	func fetchFoto() {
		guard maxCount != fotos.count else { return }
		network.fetch(
			dataType: FotoDTO.self,
			with: NetworkRequestFotosAll(offset: fotos.count),
			token: keychain.getToken()
		) { [weak self] result in
			switch result {
			case .success(let fotoDTO):
				self?.parsingFoto(from: fotoDTO)
			case .failure(let error):
				DispatchQueue.main.async {
					self?.router.showAlert(with: error.localizedDescription)
				}
			}
		}
	}
}

private extension GalleryPresenter {

	func fetchVideo() {
		network.fetch(
			dataType: VideoDTO.self,
			with: NetworkRequestVideos(),
			token: keychain.getToken()
		) { [weak self] result in
			switch result {
			case .success(let videoDTO):
				self?.parsingVideo(from: videoDTO)
			case .failure(let error):
				DispatchQueue.main.async {
					self?.router.showAlert(with: error.localizedDescription)
				}
			}
		}
	}
	
	func parsingFoto(from model: FotoDTO) {
		maxCount = model.response.count
		model.response.items.forEach { item in
			fotos.append(GalleryViewModel.Foto(
				data: item.date,
				urlPrev: item.sizes[4].url,
				urlOrig: item.origPhoto.url
			))
		}
		reloadFotoCollection()
	}
	
	func parsingVideo(from model: VideoDTO) {
		model.response.items.forEach { item in
			videos.append(GalleryViewModel.Video(
				title: item.title,
				urlPrev: item.image[3].url,
				urlVideo: item.player
			))
		}
		reloadVideoCollection()
	}
	
	func reloadFotoCollection() {
		DispatchQueue.main.async {
			self.view?.reloadFotoCollection()
		}
	}
	
	func reloadVideoCollection() {
		DispatchQueue.main.async {
			self.view?.reloadVideoCollection()
		}
	}
}

//
//  GalleryPresenter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import Foundation

protocol IGalleryPresenter {
	func viewIsReady(view: IGalleryView)
	func fetchFoto()
	func logout()
	
	func getCountFotos() -> Int
	func getFoto(at index: Int) -> GalleryViewModel.Foto
	func fotoDidSelect(at index: Int)
	
	func getCountVideo() -> Int
	func getVideo(at index: Int) -> GalleryViewModel.Video
	func videoDidSelect(at index: Int)
}

final class GalleryPresenter: IGalleryPresenter {
	
	private weak var view: IGalleryView?
	private let router: IGalleryRouter
	private let network: INetworkService
	private let authService: IAuthService
	
	private var fotos: [GalleryViewModel.Foto] = .init()
	private var videos: [GalleryViewModel.Video] = .init()
	private var maxCountPhotos: Int?
	
	init(router: IGalleryRouter, network: INetworkService, authService: IAuthService) {
		self.router = router
		self.network = network
		self.authService = authService
	}
	
	func viewIsReady(view: IGalleryView) {
		self.view = view
		fetchFoto()
		fetchVideo()
	}
	
	func logout() {
		if authService.logout() {
			router.popToLogin()
		} else {
			router.showAlert(with: AuthError.logout.errorDescription)
		}
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
		router.showPhoto(photoData: fotos[index])
	}
	
	func getCountVideo() -> Int {
		return videos.count
	}
	func getVideo(at index: Int) -> GalleryViewModel.Video {
		return videos[index]
	}
	
	func videoDidSelect(at index: Int) {
		router.showVideo(videoData: videos[index])
	}
	
	func fetchFoto() {
		guard maxCountPhotos != fotos.count else { return }
		guard let token = authService.getToken() else {
			router.showAlert(with: AuthError.logout.errorDescription)
			return
		}
		network.fetch(
			dataType: FotoDTO.self,
			with: NetworkRequestFotosAll(offset: fotos.count),
			token: token.rawValue
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
		guard let token = authService.getToken() else {
			router.showAlert(with: AuthError.logout.errorDescription)
			return
		}
		network.fetch(
			dataType: VideoDTO.self,
			with: NetworkRequestVideos(),
			token: token.rawValue
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
		maxCountPhotos = model.response.count
		model.response.items.forEach { item in
			if let urlPrev = item.sizes.first(where: { $0.type == "q"}) {
				fotos.append(GalleryViewModel.Foto(
					data: item.date,
					urlPrev: urlPrev.url,
					urlOrig: item.origPhoto.url
				))
			}
		}
		reloadFotoCollection()
	}
	
	func parsingVideo(from model: VideoDTO) {
		model.response.items.forEach { item in
			if let urlPrev = item.image.first(where: { $0.width > 400 && $0.width < 1000}) {
				videos.append(GalleryViewModel.Video(
					title: item.title,
					urlPrev: item.image[3].url,
					urlVideo: item.player
				))
			}
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

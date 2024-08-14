//
//  VideoAssembly.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import UIKit

enum VideoAssembly {
	
	static func makeModule(navigationController: UINavigationController, videoData: GalleryViewModel.Video) -> UIViewController {
		let router = VideoRouter(navigationController: navigationController)
		let presenter = VideoPresenter(router: router, videoData: videoData)
		let viewController = VideoViewController(presenter: presenter)
		
		return viewController
	}
}

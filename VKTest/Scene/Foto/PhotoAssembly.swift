//
//  PhotoAssembly.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import UIKit

enum PhotoAssembly {
	
	static func makeModule(navigationController: UINavigationController, photoData: GalleryViewModel.Foto) -> UIViewController {
		let router = PhotoRouter(navigationController: navigationController)
		let presenter = PhotoPresenter(router: router, photoData: photoData)
		let viewController = PhotoViewController(presenter: presenter)
		
		return viewController
	}
}

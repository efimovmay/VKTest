//
//  GalleryViewModel.swift
//  VKTest
//
//  Created by Aleksey Efimov on 12.08.2024.
//

import Foundation

struct GalleryViewModel {
	
	struct Foto {
		let data: Int
		let urlPrev: String
		let urlOrig: String
	}
	
	struct Video {
		let title: String
		let urlPrev: String
		let urlVideo: String
	}
}

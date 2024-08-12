//
//  FotoDTO.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import Foundation

struct FotoDTO: Decodable {
	let response: Response
	
	struct Response: Decodable {
		let count: Int
		let items: [Item]
	}
	
	struct Item: Decodable {
		let date: Int
		let sizes: [PhotoURL]
		let origPhoto: PhotoURL
	}
	
	struct PhotoURL: Decodable {
		let type: String
		let url: String
	}
}



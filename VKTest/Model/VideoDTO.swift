//
//  VideoDTO.swift
//  VKTest
//
//  Created by Aleksey Efimov on 12.08.2024.
//

import Foundation

struct VideoDTO: Decodable {
	let response: Response
	
	struct Response: Decodable {
		let items: [Item]
	}
	
	struct Item: Decodable {
		let image: [PrevURL]
		let title: String
		let player : String
	}
	
	struct PrevURL: Decodable {
		let url: String
		let width: Int
	}
}

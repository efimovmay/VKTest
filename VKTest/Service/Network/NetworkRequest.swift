//
//  NetworkRequest.swift
//
//  Created by Aleksey Efimov.
//

import Foundation

/// Протокол для создания сетевых запросов.
protocol INetworkRequest {
	/// Путь запроса.
	var path: String { get }
	/// HTTP Метод, указывающий тип запроса.
	var method: HTTPMethod { get }
	/// HTTP заголовок.
	var header: [String: String]? { get }
	/// Параметры запроса.
	var parameters: [String: String] { get }
}

extension INetworkRequest {
	var header: [String: String]? { nil }
}

struct NetworkRequestFotos: INetworkRequest {
	let path = NetworkEndpoints.fotoGet.description
	let method = HTTPMethod.get
	let parameters: [String : String]
	
	init(token: String) {
		parameters = [
			"owner_id" : "-128666765",
			"album_id" : "266276915",
			"access_token" : token,
			"rev" : "0",
			"v" : "5.199"
		]
	}
}

struct NetworkRequestVideos: INetworkRequest {
	let path = NetworkEndpoints.videoGet.description
	let method = HTTPMethod.get
	let parameters: [String : String]
	
	init(offset: Int) {
		parameters = [
			"owner_id" : "-128666765",
			"v" : "5.199"
		]
	}
}

struct NetworkRequestAuth: INetworkRequest {
	let path = NetworkEndpoints.authorize.description
	let method = HTTPMethod.get
	let parameters: [String : String]
	
	init() {
		parameters = [
			"client_id" : NetworkEndpoints.clientId,
			"redirect_uri" : "https://oauth.vk.com/blank.html",
			"display" : "mobile",
			"response_type" : "token"
		]
	}
}


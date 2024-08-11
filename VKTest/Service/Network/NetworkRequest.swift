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

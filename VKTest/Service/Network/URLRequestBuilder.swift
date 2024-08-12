//
//  URLRequestBuilder.swift
//
//  Created by Aleksey Efimov.
//

import Foundation

struct Token {
	let rawValue: String
}

/// Сервис, собирающий запрос из NetworkRequest.
protocol IURLRequestBuilder {
	/// Сервис, собирающий запрос из NetworkRequest.
	func build(forRequest requestData: INetworkRequest) -> URLRequest?
}

/// Сервис, собирающий запрос из NetworkRequest.
struct URLRequestBuilder: IURLRequestBuilder {

	var baseUrl: String

	func build(forRequest requestData: INetworkRequest) -> URLRequest? {
		guard var urlComponents = URLComponents(string: baseUrl) else {
			return nil
		}
		urlComponents.path = requestData.path
		urlComponents.queryItems = requestData.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
		guard let url = urlComponents.url else {
			return nil
		}
		var request = URLRequest(url: url)
		request.httpMethod = requestData.method.rawValue
		
		return request
	}
}

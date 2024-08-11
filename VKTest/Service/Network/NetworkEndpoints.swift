//
//  NetworkEndpoints.swift
//
//  Created by Aleksey Efimov.
//

import Foundation

enum NetworkEndpoints {
	static let authBaseURL = "https://oauth.vk.com"
	static let baseURL = "https://api.vk.com"
	static let clientId = "52125494"
	
	case authorize
}

extension NetworkEndpoints: CustomStringConvertible {
	var description: String {
		switch self {
		case .authorize:
			"/authorize"
		}
	}
}


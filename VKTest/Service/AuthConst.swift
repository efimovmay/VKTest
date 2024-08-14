//
//  AuthConst.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import Foundation

enum AuthConst {
	static let client: String = "VK"
	
	case token
	case account
	case expiration
	
	var apiKey: String {
		switch self {
		case .account:
			"user_id"
		case .expiration:
			"expires_in"
		case .token:
			"access_token"
		}
	}
}

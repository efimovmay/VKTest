//
//  AuthService.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import Foundation

struct Token: Codable {
	let rawValue: String
	let expiration: Double
}

protocol IAuthService {
	func login(token: String, expiration: Double) -> Bool
	func logout() -> Bool
	func getToken() -> Token?
}

final class AuthService: IAuthService {
	
	private let keychainService: IKeychainService
	
	init(keychainService: IKeychainService) {
		self.keychainService = keychainService
	}
	
	func login(token: String, expiration: Double) -> Bool {
		let expirationFromNow = Date.now.timeIntervalSince1970 + expiration
		let token = Token(rawValue: token, expiration: expirationFromNow)
		guard let tokenData = try? JSONEncoder().encode(token) else { return false }
		return keychainService.saveToken(tokenData: tokenData)
	}
	
	func logout() -> Bool {
		return keychainService.deleteToken()
	}
	
	func getToken() -> Token? {
		guard let tokenData = keychainService.getToken(),
			  let token = try? JSONDecoder().decode(Token.self, from: tokenData),
			  token.expiration > Date.now.timeIntervalSince1970 else {
			return nil
		}
		return token
	}
}

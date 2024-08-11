//
//  KeychainService.swift
//  VKTest
//
//  Created by Aleksey Efimov on 10.08.2024.
//

import Foundation

struct KeychainService {
	
	let account: String
	
	@discardableResult
	func saveToken(token: String) -> Bool {
		guard let tokenData = token.data(using: .utf8) else { return false }
		let keychainItem = [
			kSecAttrAccount: account,
			kSecValueData: tokenData,
			kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
			kSecClass: kSecClassGenericPassword
		] as CFDictionary
		
		let status = SecItemCopyMatching(keychainItem as CFDictionary, nil)
		if status == errSecSuccess {
			let attributesToUpdate: [String: Any] = [kSecValueData as String: tokenData]
			let updateStatus = SecItemUpdate(keychainItem as CFDictionary, attributesToUpdate as CFDictionary)
			return updateStatus == errSecSuccess
		} else {
			let addStatus = SecItemAdd(keychainItem as CFDictionary, nil)
			return addStatus == errSecSuccess
		}
	}
	
	func getToken() -> String? {
		let query = [
			kSecAttrAccount: account,
			kSecReturnData: true,
			kSecClass: kSecClassGenericPassword,
			kSecMatchLimit: kSecMatchLimitOne
		] as CFDictionary
		
		var dataTypeRef: AnyObject?
		let status = SecItemCopyMatching(query, &dataTypeRef)
		
		if status == errSecSuccess, let data = dataTypeRef as? Data {
			return String(data: data, encoding: .utf8)
		} else {
			return nil
		}
	}
	
	@discardableResult
	func deleteToken() -> Bool {
		let query = [
			kSecAttrAccount: account,
			kSecClass: kSecClassGenericPassword
		] as CFDictionary
		
		let status = SecItemDelete(query)
		return status == errSecSuccess
	}
}

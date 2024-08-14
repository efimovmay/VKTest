//
//  KeychainService.swift
//  VKTest
//
//  Created by Aleksey Efimov on 10.08.2024.
//

import Foundation

protocol IKeychainService {
	func saveToken(tokenData: Data) -> Bool
	func getToken() -> Data?
	func deleteToken() -> Bool
}

struct KeychainService: IKeychainService {

	func saveToken(tokenData: Data) -> Bool {
		let keychainItem = [
			kSecAttrAccount: AuthConst.client,
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
	
	func getToken() -> Data? {
		let query = [
			kSecAttrAccount: AuthConst.client,
			kSecReturnData: true,
			kSecClass: kSecClassGenericPassword,
			kSecMatchLimit: kSecMatchLimitOne
		] as CFDictionary
		
		var dataTypeRef: AnyObject?
		let status = SecItemCopyMatching(query, &dataTypeRef)
		
		if status == errSecSuccess, let data = dataTypeRef as? Data {
			return data
		} else {
			return nil
		}
	}
	
	func deleteToken() -> Bool {
		let query = [
			kSecAttrAccount: AuthConst.client,
			kSecClass: kSecClassGenericPassword
		] as CFDictionary
		
		let status = SecItemDelete(query)
		return status == errSecSuccess
	}
}

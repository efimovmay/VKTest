//
//  KeychainService.swift
//  VKTest
//
//  Created by Aleksey Efimov on 10.08.2024.
//

import Foundation

struct KeychainService {
	let service: String
	let account: String
	
	func save(item: String) -> Bool {
		guard let itemData = item.data(using: .utf8) else { return false }
		let keychainItem = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecValueData: itemData,
			kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
			kSecClass: kSecClassGenericPassword
		] as CFDictionary
		
		let status = SecItemAdd(keychainItem, nil)
		return status == errSecSuccess
	}
	
	func get() -> String? {
		let query = [
			kSecAttrService: service,
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
	
	func delete() -> Bool {
		let query = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecClass: kSecClassGenericPassword
		] as CFDictionary
		
		let status = SecItemDelete(query)
		return status == errSecSuccess
	}
	
	func update(item: String) -> Bool {
		guard let itemData = item.data(using: .utf8) else { return false }
		
		let query = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecClass: kSecClassGenericPassword
		] as CFDictionary
		
		let field = [
			kSecValueData: itemData
		] as CFDictionary
		
		let status = SecItemUpdate(query, field)
		return status == errSecSuccess
	}
}

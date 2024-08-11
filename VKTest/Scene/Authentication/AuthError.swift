//
//  AuthError.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import Foundation

enum AuthError: Error {
	case webLoadFail
}

extension AuthError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .webLoadFail:
			L10n.AuthError.webLoadFail
		}
	}
}

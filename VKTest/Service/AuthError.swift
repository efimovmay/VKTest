//
//  AuthError.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import Foundation

enum AuthError: Error {
	case save
	case logout
	case get
}

extension AuthError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .save:
			L10n.AuthError.save
		case .logout:
			L10n.AuthError.logout
		case .get:
			L10n.AuthError.get
		}
	}
}

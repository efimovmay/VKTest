//
//  WebViewError.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import Foundation

enum WebViewError: Error {
	case navigationFail(Error)
}

extension WebViewError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .navigationFail(let error):
			return "\(L10n.WebView.error): \(error)"
		}
	}
}

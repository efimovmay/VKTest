//
//  Strings.swift
//
//  Created by Aleksey Efimov
//

import Foundation

enum L10n {
	
	enum Common {
		static let ok = NSLocalizedString("common.ok", comment: "")
		static let error = NSLocalizedString("common.error", comment: "")
		static let done = NSLocalizedString("common.done", comment: "")
		static let cancel = NSLocalizedString("common.cancel", comment: "")
	}
	
	enum networkError {
		static let invalidURL = NSLocalizedString("networkError.invalidURL", comment: "")
		static let networkError = NSLocalizedString("networkError.networkError", comment: "")
		static let invalidResponse = NSLocalizedString("networkError.invalidResponse", comment: "")
		static let invalidStatusCode = NSLocalizedString("networkError.invalidStatusCode", comment: "")
		static let noData = NSLocalizedString("networkError.noData", comment: "")
		static let failedToDecodeResponse = NSLocalizedString("networkError.failedToDecodeResponse", comment: "")
	}
	
	enum LoginScreen {
		static let title = "Mobile Up\nGallery"
		static let textButton = "Вход через VK"
	}
}

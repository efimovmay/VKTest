//
//  NetworkError.swift
//
//  Created by Aleksey Efimov.
//

import Foundation

/// Ошибки сетевого слоя.
enum NetworkServiceError: Error {
	/// Ошибка URL.
	case invalidURL
	/// Сетевая ошибка.
	case networkError(Error)
	/// Ответ сервера имеет неожиданный формат.
	case invalidResponse
	/// Статус кода ответа, который не входит в диапазон успешных `(200..<300)`.
	case invalidStatusCode(Int)
	/// Данные отсутствуют.
	case noData
	/// Не удалось декодировать ответ.
	case failedToDecodeResponse(Error)
}

extension NetworkServiceError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return L10n.NetworkError.invalidURL
		case .networkError:
			return L10n.NetworkError.networkError
		case .invalidResponse:
			return L10n.NetworkError.invalidResponse
		case .invalidStatusCode(let code):
			return "\(L10n.NetworkError.invalidStatusCode) (\(code))"
		case .noData:
			return L10n.NetworkError.noData
		case .failedToDecodeResponse:
			return L10n.NetworkError.failedToDecodeResponse
		}
	}
}

//
//  NetworkService.swift
//
//  Created by Aleksey Efimov.
//

import Foundation

protocol INetworkService {
	
	/// Метод для получения <T> данных.
	/// - Parameters:
	///   - dataType: Тип данных для декодирования.
	///   - requestData: данные для созданиия запроса
	func fetch<T: Decodable>(
		dataType: T.Type,
		with requestData: INetworkRequest,
		completion: @escaping(Result<T, NetworkServiceError>) -> Void
	)
	
	/// Метод для получения <T> данных по URL.
	/// - Parameters:
	///   - dataType: Тип данных для декодирования.
	///   - url: Адрес запроса.
	func fetch<T: Decodable>(
		dataType: T.Type,
		url: String,
		completion: @escaping(Result<T, NetworkServiceError>) -> Void
	)
	
	/// Метод для получения Data по URLRequest.
	/// - Parameters:
	///   - request: Сформированный URLRequest.
	func perform(
		request: URLRequest,
		completion: @escaping (Result<Data, NetworkServiceError>) -> Void
	)
}

final class NetworkService {
	
	private let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
	private let requestBuilder: IURLRequestBuilder
	private let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}()
	
	init(baseUrl: String) {
		requestBuilder = URLRequestBuilder(baseUrl: baseUrl)
	}
}

extension NetworkService: INetworkService {
	
	func fetch<T: Decodable>(
		dataType: T.Type,
		with request: INetworkRequest,
		completion: @escaping(Result<T, NetworkServiceError>) -> Void
	) {
		guard let request = requestBuilder.build(forRequest: request) else {
			completion(.failure(.invalidURL))
			return
		}
		perform(request: request) { result in
			switch result {
			case .success(let data):
				do {
					let decodedData = try self.decoder.decode(T.self, from: data)
					completion(.success(decodedData))
				} catch {
					completion(.failure(.failedToDecodeResponse(error)))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func fetch<T: Decodable>(
		dataType: T.Type,
		url: String,
		completion: @escaping(Result<T, NetworkServiceError>) -> Void
	) {
		guard let url = URL(string: url) else {
			completion(.failure(.invalidURL))
			return
		}
		let request = URLRequest(url: url)
		
		perform(request: request) { result in
			switch result {
			case .success(let data):
				do {
					let decodedData = try self.decoder.decode(T.self, from: data)
					completion(.success(decodedData))
				} catch {
					completion(.failure(.failedToDecodeResponse(error)))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func perform(
		request: URLRequest,
		completion: @escaping (Result<Data, NetworkServiceError>) -> Void
	) {
		session.dataTask(with: request) { (data, response, error) in
			if let error = error {
				completion(.failure(.networkError(error)))
			}
			guard let httpResponse = response as? HTTPURLResponse else {
				completion(.failure(.invalidResponse))
				return
			}
			guard (200...299).contains(httpResponse.statusCode) else {
				completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
				return
			}
			guard let data = data else {
				completion(.failure(.noData))
				return
			}
			completion(.success(data))
		}.resume()
	}
}

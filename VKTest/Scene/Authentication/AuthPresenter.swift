//
//  AuthPresenter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import Foundation
import WebKit

protocol IAuthPresenter: AnyObject, WKNavigationDelegate {
	func viewIsReady(view: IAuthView)
}

final class AuthPresenter: NSObject, IAuthPresenter {
	// MARK: - Dependencies
	
	private weak var view: IAuthView?
	private let router: IAuthRouter
	
	// MARK: - Initialization
	
	init(router: IAuthRouter) {
		self.router = router
	}
	
	func viewIsReady(view: IAuthView) {
		self.view = view
		guard let request = constructAuthUrl() else { return }
		view.loadWebView(request: request)
	}
	
	func constructAuthUrl() -> URLRequest? {
		guard var components = URLComponents(string: "https://oauth.vk.com") else { return nil }
		
		components.path = "/authorize"
		let queryItems: [String : String] = [
			"client_id" : "52125494",
			"redirect_uri" : "https://oauth.vk.com/blank.html",
			"display" : "mobile",
			"response_type" : "token"
		]
		components.queryItems = queryItems.map({ URLQueryItem(name: $0.key, value: $0.value )})
		
		guard let url = components.url else { return nil }
		let request = URLRequest(url: url)
		
		return request
	}
}

private extension AuthPresenter {
	func routeToGallery() {
		router.routeToGalleryView()
	}
}

extension AuthPresenter: WKNavigationDelegate {
	func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
		guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
			decisionHandler(.allow)
			return
		}
		let params = fragment.components(separatedBy: "&")
			.map{ $0.components(separatedBy: "=") }
			.reduce([String:String]()) { res, param in
				var dict = res
				let key = param[0]
				let value = param[1]
				dict[key] = value
				return dict
			}
		
		if let userId = params["user_id"], let token = params["access_token"], let exp = params["expires_in"] {
			print(userId)
			print(token)
			print(exp)
			routeToGallery()
		}
		decisionHandler(.cancel)
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		view?.loadPageDone()
	}
	
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		debugPrint("didFail")
	}
}

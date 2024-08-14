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
	
	private weak var view: IAuthView?
	private let router: IAuthRouter
	
	init(router: IAuthRouter) {
		self.router = router
	}
	
	func viewIsReady(view: IAuthView) {
		self.view = view
		guard let request = URLRequestBuilder(baseUrl: NetworkEndpoints.authBaseURL).build(
			forRequest: NetworkRequestAuth(),
			token: nil
		) else { return }
		view.loadWebView(request: request)
	}
}

extension AuthPresenter: WKNavigationDelegate {
	func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
		guard let url = navigationResponse.response.url,
			  url.path == NetworkEndpoints.blank.description,
			  let fragment = url.fragment else {
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
		
		if let userId = params["user_id"], let token = params["access_token"] {
			UserDefaults.standard.set(userId, forKey: AuthConst.account)
			let keychainService = KeychainService(account: userId)
			keychainService.saveToken(token: token)
			router.routeToGalleryView(keychain: keychainService)
		}
		decisionHandler(.cancel)
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		view?.loadPageDone()
	}
	
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		router.showAlert(with: WebViewError.navigationFail(error).localizedDescription)
	}
	
	func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
		router.showAlert(with: WebViewError.navigationFail(error).localizedDescription)
	}
}

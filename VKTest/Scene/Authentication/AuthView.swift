//
//  AuthView.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit
import WebKit

final class AuthView: UIView {

	lazy var activityIndicator: UIActivityIndicatorView = makeActivityIndicator()
	lazy var webView: WKWebView = makeWebView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension AuthView {
	func setupUI() {
		backgroundColor = .white
	}
	
	func setupLayout() {
		addSubview(webView)
		webView.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
			webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Sizes.Padding.double),
			webView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			webView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			
			activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
		])
	}
	
	func makeWebView() -> WKWebView {
		let configuration = WKWebViewConfiguration()
		configuration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
		let webView = WKWebView(frame: CGRectZero, configuration: configuration)
		webView.translatesAutoresizingMaskIntoConstraints = false
		return webView
	}
	
	func makeActivityIndicator() -> UIActivityIndicatorView {
		let indicator = UIActivityIndicatorView()
		indicator.style = .large
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}
}

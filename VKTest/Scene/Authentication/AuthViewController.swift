//
//  AuthViewController.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit
import WebKit

protocol IAuthView: AnyObject {
	func loadWebView(request: URLRequest)
	func loadPageDone()
}

class AuthViewController: UIViewController {
	
	private let presenter: IAuthPresenter
	private lazy var contentView = AuthView()
	
	init(presenter: IAuthPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		view = contentView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.viewIsReady(view: self)
		setupUI()
	}
}

private extension AuthViewController {
	func setupUI() {
		contentView.webView.navigationDelegate = presenter
	}
}

extension AuthViewController: IAuthView {
	func loadWebView(request: URLRequest) {
		contentView.webView.load(request)
		contentView.activityIndicator.startAnimating()
	}
	
	func loadPageDone() {
		contentView.activityIndicator.stopAnimating()
	}
}

//
//  VideoViewController.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import UIKit
import WebKit

protocol IVideoView: AnyObject {
	func render(title: String, videoURL: URL?)
	func loadPageDone()
}

final class VideoViewController: UIViewController {
	
	private let presenter: IVideoPresenter
	
	private lazy var webView: WKWebView = makeWebView()
	private lazy var activityIndicator: UIActivityIndicatorView = makeActivityIndicator()
	
	private var videoURL: URL?
	
	init(presenter: IVideoPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupLayout()
		presenter.viewIsReady(view: self)
	}
}

private extension VideoViewController {
	@objc
	func menuTapped() {
		if let videoURL = videoURL as? NSURL {
			let activityItems = [videoURL] as [AnyObject]
			presenter.share(activityItems: activityItems)
		} else {
			presenter.showError(error: L10n.PhotoScreen.sendError)
		}
	}
}

private extension VideoViewController {
	func setupUI() {
		view.backgroundColor = .systemBackground
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .action,
			target: self,
			action: #selector(menuTapped)
		)
		
		activityIndicator.startAnimating()
	}
	
	func setupLayout() {
		view.addSubview(webView)
		view.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
			webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}
	
	func makeWebView() -> WKWebView {
		let webView = WKWebView()
		webView.sizeToFit()
		webView.scrollView.isScrollEnabled = false
		webView.translatesAutoresizingMaskIntoConstraints = false
		webView.navigationDelegate = presenter
		return webView
	}
	
	func makeActivityIndicator() -> UIActivityIndicatorView {
		let indicator = UIActivityIndicatorView()
		indicator.style = .large
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}
}

extension VideoViewController: IVideoView {
	func render(title: String, videoURL: URL?) {
		self.title = title
		self.videoURL = videoURL
		
		if let videoURL = videoURL {
			let request = URLRequest(url: videoURL)
			webView.load(request)
		}
	}
	
	func loadPageDone() {
		activityIndicator.stopAnimating()
	}
}

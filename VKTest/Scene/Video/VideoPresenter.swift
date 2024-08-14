//
//  VideoPresenter.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import Foundation
import WebKit

protocol IVideoPresenter: AnyObject, WKNavigationDelegate {
	func viewIsReady(view: IVideoView)
	func share(activityItems: [AnyObject])
	func showError(error: String?)
}

final class VideoPresenter: NSObject, IVideoPresenter {
	
	private weak var view: IVideoView?
	private let router: IVideoRouter
	
	private let videoData: GalleryViewModel.Video
	
	init(router: IVideoRouter, videoData: GalleryViewModel.Video) {
		self.router = router
		self.videoData = videoData
	}
	
	func viewIsReady(view: IVideoView) {
		self.view = view
		view.render(title: videoData.title, videoURL: URL(string: videoData.urlVideo))
	}
	
	func share(activityItems: [AnyObject]) {
		router.showShareMenu(with: activityItems)
	}
	
	func showError(error: String?) {
		router.showAlert(with: L10n.Common.error, and: error)
	}
}

extension VideoPresenter: WKNavigationDelegate {
	func webView(_: WKWebView, didCommit: WKNavigation!) {
		view?.loadPageDone()
	}
	
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		router.showAlert(with: L10n.Common.error, and: WebViewError.navigationFail(error).localizedDescription)
	}
	
	func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
		router.showAlert(with: L10n.Common.error, and: WebViewError.navigationFail(error).localizedDescription)
	}
}

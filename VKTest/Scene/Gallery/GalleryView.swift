//
//  GalleryView.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import UIKit

final class GalleryView: UIView {
	
	
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

private extension GalleryView {
	func setupUI() {
		backgroundColor = .systemBackground
	}
	
	func setupLayout() {
//		addSubview(webView)
//		webView.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
//			webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Sizes.Padding.double),
//			webView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//			webView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//			webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//
//			activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
//			activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
		])
	}
}

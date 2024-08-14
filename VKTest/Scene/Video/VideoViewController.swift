//
//  VideoViewController.swift
//  VKTest
//
//  Created by Aleksey Efimov on 14.08.2024.
//

import UIKit

protocol IVideoView: AnyObject {
	func render(title: String, videoURL: URL?)
}

final class VideoViewController: UIViewController {
	
	private let presenter: IVideoPresenter
	
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
//		view.addSubview(videoImageView)
		view.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
//			videoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Sizes.Padding.double),
//			videoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//			videoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//			videoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}
	
	func makePhotoView() -> UIImageView {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.clipsToBounds = true
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
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

	}
}

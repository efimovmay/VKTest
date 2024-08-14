//
//  PhotoViewController.swift
//  VKTest
//
//  Created by Aleksey Efimov on 13.08.2024.
//

import UIKit

protocol IPhotoView: AnyObject {
	func render(title: String, photoURL: URL?)
}

final class PhotoViewController: UIViewController {
	
	private let presenter: IPhotoPresenter
	
	private lazy var photoImageView: UIImageView = makePhotoView()
	private lazy var activityIndicator: UIActivityIndicatorView = makeActivityIndicator()
	private var photoURL: URL?
	
	init(presenter: IPhotoPresenter) {
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

private extension PhotoViewController {
	@objc
	func menuTapped() {
		if let image: UIImage = photoImageView.image, let photoURL = photoURL as? NSURL {
			let activityItems = [photoURL, image] as [AnyObject]
			presenter.share(activityItems: activityItems)
		} else {
			presenter.showError(error: L10n.PhotoScreen.sendError)
		}
	}
}

private extension PhotoViewController {
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
		view.addSubview(photoImageView)
		view.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
			photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Sizes.Padding.double),
			photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
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

extension PhotoViewController: IPhotoView {
	func render(title: String, photoURL: URL?) {
		self.title = title
		self.photoURL = photoURL
		photoImageView.kf.setImage(with: photoURL) { [weak self] result in
			switch result {
			case .success(_):
				self?.activityIndicator.stopAnimating()
			case .failure(let erorr):
				self?.presenter.showError(error: erorr.localizedDescription)
			}
		}
	}
}

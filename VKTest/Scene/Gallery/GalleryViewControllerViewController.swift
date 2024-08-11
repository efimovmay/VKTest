//
//  GalleryViewController.swift
//  VKTest
//
//  Created by Aleksey Efimov on 10.08.2024.
//
//

import UIKit

protocol IGalleryView: AnyObject {
	
}

class GalleryViewController: UIViewController {
	
	private let presenter: IGalleryPresenter
	private lazy var contentView = AuthView()
	
	init(presenter: IGalleryPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad(){
		super.viewDidLoad()
		presenter.viewIsReady(view: self)
		setupUI()
	}
}

private extension GalleryViewController {
	func setupUI() {
	
	}
}


extension GalleryViewController: IGalleryView {
	
}

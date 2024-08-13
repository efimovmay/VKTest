//
//  LoginViewController.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit

class LoginViewController: UIViewController {
	
	private let presenter: ILoginPresenter
	private lazy var contentView = LoginView()
	
	// MARK: - Initialization
	
	init(presenter: ILoginPresenter) {
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
		setupUI()
	}
}

// MARK: - Actions

private extension LoginViewController {
	@objc
	func authButtonPressed() {
		presenter.routeToAuthScreen()
	}
}

// MARK: - SetupUI

private extension LoginViewController {
	func setupUI() {
		contentView.authButton.addTarget(self, action: #selector(authButtonPressed), for: .touchUpInside)
	}
}

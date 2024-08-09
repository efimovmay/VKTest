//
//  LoginViewController.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit

protocol ILoginView: AnyObject {
	
}

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
	}
}

extension LoginViewController: ILoginView {
	
}


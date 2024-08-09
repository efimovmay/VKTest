//
//  LoginView.swift
//  VKTest
//
//  Created by Aleksey Efimov on 09.08.2024.
//

import UIKit

final class LoginView: UIView {
	
	lazy var authButton: UIButton = makeAuthButton()
	lazy var titleLabel: UILabel = makeTitleLabel()
	
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

private extension LoginView {
	func setupUI() {
		backgroundColor = .systemBackground
	}
	
	func setupLayout() {
		addSubview(titleLabel)
		addSubview(authButton)
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 160),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.semiDouble),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Padding.semiDouble),
			
			authButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Sizes.Padding.half),
			authButton.heightAnchor.constraint(equalToConstant: Sizes.LoginScreen.authButtonHeigth),
			authButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.normal),
			authButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Padding.normal),
		])
	}
	
	func makeTitleLabel() -> UILabel {
		let label = UILabel()
		label.numberOfLines = .zero
		label.text = L10n.LoginScreen.title
		label.font = UIFont.boldSystemFont(ofSize: Sizes.LoginScreen.titleFont)
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	func makeAuthButton() -> UIButton {
		let button = UIButton()
		var config = UIButton.Configuration.filled()
		config.background.cornerRadius = Sizes.LoginScreen.authButtonCorner
		config.baseBackgroundColor = .black
		config.title = L10n.LoginScreen.textButton
		button.configuration = config

		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}
}

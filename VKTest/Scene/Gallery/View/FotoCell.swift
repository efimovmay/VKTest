//
//  FotoCell.swift
//  VKTest
//
//  Created by Aleksey Efimov on 12.08.2024.
//

import UIKit
import Kingfisher

final class FotoViewCell: UICollectionViewCell {
	
	static let identifier = String(describing: FotoViewCell.self)

	lazy var fotoImageView: UIImageView = makeImageView()


	// MARK: - Initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		fotoImageView.image = nil
	}
	
	func configure(imageUrl: String) {
		fotoImageView.kf.setImage(with: URL(string: imageUrl))
	}
}

// MARK: - SetupUI

private extension FotoViewCell {
	
	func setupLayout() {
		addSubview(fotoImageView)
		
		NSLayoutConstraint.activate([
			fotoImageView.topAnchor.constraint(equalTo: topAnchor),
			fotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			fotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			fotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
	
	func makeImageView() -> UIImageView {
		let image = UIImageView()
		image.contentMode = .scaleAspectFill
		image.tintColor = .gray
		image.clipsToBounds = true
		image.isUserInteractionEnabled = true
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}
}

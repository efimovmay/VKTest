//
//  VideoCell.swift
//  VKTest
//
//  Created by Aleksey Efimov on 12.08.2024.
//

import UIKit
import Kingfisher

final class VideoViewCell: UICollectionViewCell {
	
	static let identifier = String(describing: VideoViewCell.self)
	
	lazy var videoImageView: UIImageView = makeImageView()
	lazy var titleView: UIView = makeTitleView()
	lazy var titleLabel: UILabel = makeLabel()
	
	
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
		videoImageView.image = nil
	}
	
	func configure(imageUrl: String, title: String) {
		titleLabel.text = title
		videoImageView.kf.setImage(with: URL(string: imageUrl))
	}
}

// MARK: - SetupUI

private extension VideoViewCell {
	
	func setupLayout() {
		addSubview(videoImageView)
		videoImageView.addSubview(titleView)
		titleView.addSubview(titleLabel)
		
		NSLayoutConstraint.activate([
			videoImageView.topAnchor.constraint(equalTo: topAnchor),
			videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			videoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			videoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			titleView.bottomAnchor.constraint(equalTo: videoImageView.bottomAnchor, constant: -Sizes.Padding.normal),
			titleView.trailingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: -Sizes.Padding.normal),
			titleView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: Sizes.Padding.semiDouble),
			titleView.heightAnchor.constraint(greaterThanOrEqualTo: titleLabel.heightAnchor, constant: Sizes.Padding.normal),
			
			titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
			titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width * 2/3),
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
	
	func makeLabel() -> UILabel {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .black
		label.font = UIFont.systemFont(ofSize: 13)
		label.numberOfLines = .zero
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	func makeTitleView() -> UIView{
		let view = UIView()
		view.backgroundColor = .white.withAlphaComponent(0.5)
		view.layer.cornerRadius = Sizes.Padding.normal
		view.clipsToBounds = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}
}

//
//  GalleryView.swift
//  VKTest
//
//  Created by Aleksey Efimov on 11.08.2024.
//

import UIKit

final class GalleryView: UIView {
	lazy var segmentControl = makeSegmentControl()
	lazy var fotoCollectionView: UICollectionView = makeFotoCollectionView()
	lazy var videoCollectionView: UICollectionView = makeVideoCollectionView()
	
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
		addSubview(segmentControl)
		addSubview(fotoCollectionView)
		addSubview(videoCollectionView)
		
		NSLayoutConstraint.activate([
			segmentControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Sizes.Padding.half),
			segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.normal),
			segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Padding.normal),
			segmentControl.heightAnchor.constraint(equalToConstant: Sizes.Padding.double),
			
			fotoCollectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: Sizes.Padding.half),
			fotoCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			fotoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			fotoCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			videoCollectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: Sizes.Padding.half),
			videoCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			videoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			videoCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
	
	func makeSegmentControl() -> UISegmentedControl {
		let segmentControl = UISegmentedControl(items: [
			L10n.GalleryScreen.segmentFoto,
			L10n.GalleryScreen.segmentVideo
		])
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
		segmentControl.selectedSegmentIndex = GalleryViewModel.Collections.photo.tag
		return segmentControl
	}
	
	func makeFotoCollectionView() -> UICollectionView {
		let collection = UICollectionView(frame: .zero, collectionViewLayout: createFotosCollectionLayout())
		collection.tag = GalleryViewModel.Collections.photo.tag
		collection.isHidden = false
		collection.register(
			FotoViewCell.self,
			forCellWithReuseIdentifier: FotoViewCell.identifier
		)
		collection.translatesAutoresizingMaskIntoConstraints = false
		
		return collection
	}
	
	func createFotosCollectionLayout() -> UICollectionViewLayout {
		let sizeItem = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalHeight(1.0)
		)
		let item = NSCollectionLayoutItem(layoutSize: sizeItem)
		
		let groupeSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalWidth(0.5)
		)
		let groupe = NSCollectionLayoutGroup.horizontal(layoutSize: groupeSize, subitem: item, count: 2)
		groupe.interItemSpacing = .fixed(4)
		
		let section = NSCollectionLayoutSection(group: groupe)
		section.interGroupSpacing = 4
		
		let layout = UICollectionViewCompositionalLayout(section: section)
		return layout
	}
	
	func makeVideoCollectionView() -> UICollectionView {
		let collection = UICollectionView(frame: .zero, collectionViewLayout: createVideoCollectionLayout())
		collection.tag = GalleryViewModel.Collections.video.tag
		collection.isHidden = true
		collection.register(
			VideoViewCell.self,
			forCellWithReuseIdentifier: VideoViewCell.identifier
		)
		collection.translatesAutoresizingMaskIntoConstraints = false
		
		return collection
	}
	
	func createVideoCollectionLayout() -> UICollectionViewLayout {
		let sizeItem = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalHeight(1.0)
		)
		let item = NSCollectionLayoutItem(layoutSize: sizeItem)
		
		let groupeSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalWidth(0.56)
		)
		let groupe = NSCollectionLayoutGroup.horizontal(layoutSize: groupeSize, subitem: item, count: 1)
		
		let section = NSCollectionLayoutSection(group: groupe)
		section.interGroupSpacing = 4
		
		let layout = UICollectionViewCompositionalLayout(section: section)
		return layout
	}
}

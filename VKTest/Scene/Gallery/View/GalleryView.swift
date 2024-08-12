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
		
		NSLayoutConstraint.activate([
			segmentControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Sizes.Padding.half),
			segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.normal),
			segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Padding.normal),
			segmentControl.heightAnchor.constraint(equalToConstant: Sizes.Padding.double),
			
			fotoCollectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: Sizes.Padding.half),
			fotoCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			fotoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			fotoCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
	
	func makeSegmentControl() -> UISegmentedControl {
		let segmentControl = UISegmentedControl(items: [
			L10n.GalleryScreen.segmentFoto,
			L10n.GalleryScreen.segmentVideo
		])
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
		segmentControl.selectedSegmentIndex = 0
		return segmentControl
	}
	
	func makeFotoCollectionView() -> UICollectionView {
		let collection = UICollectionView(frame: .zero, collectionViewLayout: createFotosCollectionLayout())
		collection.register(
			FotoViewCell.self,
			forCellWithReuseIdentifier: FotoViewCell.identifier
		)
		//		collection.backgroundColor = .clear
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
}

//
//  GalleryViewController.swift
//  VKTest
//
//  Created by Aleksey Efimov on 10.08.2024.
//
//

import UIKit

protocol IGalleryView: AnyObject {
	func reloadFotoCollection()
}

class GalleryViewController: UIViewController {
	
	private let presenter: IGalleryPresenter
	private lazy var contentView = GalleryView()
	
	init(presenter: IGalleryPresenter) {
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
	
	override func viewDidLoad(){
		super.viewDidLoad()
		presenter.viewIsReady(view: self)
		setupUI()
	}
}

private extension GalleryViewController {
	@objc func segmentChanged(_ sender: UISegmentedControl) {
		switchState(toShowVideo: sender.selectedSegmentIndex == 1)
	}
	
	@objc
	func logout() {
	}
	
	func switchState(toShowVideo: Bool) {
		if toShowVideo {
//			interactor?.needConvertText(text: textViewEditor.text)
//			textViewEditor.isHidden = true
//			textViewPreview.isHidden = false
		} else {
//			textViewEditor.isHidden = false
//			textViewPreview.isHidden = true
		}
	}
}

private extension GalleryViewController {
	func setupUI() {
		title = L10n.GalleryScreen.title
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: L10n.GalleryScreen.logout,
			style: .plain,
			target: self,
			action: #selector(logout)
		)
		
		contentView.segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
		contentView.fotoCollectionView.dataSource = self
	}
}

extension GalleryViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		presenter.getCountFotos()
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: FotoViewCell.identifier,
			for: indexPath
		) as? FotoViewCell else {
			return UICollectionViewCell()
		}
		cell.fotoImageView.image = .checkmark
		
		return cell
	}
}

extension GalleryViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter.fotoDidSelect(at: indexPath.item)
	}
}

extension GalleryViewController: IGalleryView {
	func reloadFotoCollection() {
		contentView.fotoCollectionView.reloadData()
	}
}

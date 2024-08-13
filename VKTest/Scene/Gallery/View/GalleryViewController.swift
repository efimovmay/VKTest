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
	func reloadVideoCollection()
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
		presenter.logout()
	}
	
	func switchState(toShowVideo: Bool) {
		if toShowVideo {
			contentView.fotoCollectionView.isHidden = true
			contentView.videoCollectionView.isHidden = false
		} else {
			contentView.videoCollectionView.isHidden = true
			contentView.fotoCollectionView.isHidden = false
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
		navigationItem.rightBarButtonItem?.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
		
		contentView.segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
		
		contentView.fotoCollectionView.dataSource = self
		contentView.fotoCollectionView.delegate = self
		
		contentView.videoCollectionView.dataSource = self
		contentView.videoCollectionView.delegate = self
	}
}

extension GalleryViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch collectionView.tag {
		case 1:
			presenter.getCountFotos()
		default:
			presenter.getCountVideo()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch collectionView.tag {
		case 1:
			guard let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: FotoViewCell.identifier,
				for: indexPath
			) as? FotoViewCell else {
				return UICollectionViewCell()
			}
			let fotoData = presenter.getFoto(at: indexPath.item)
			cell.configure(imageUrl: fotoData.urlPrev)
			
			return cell
		default:
			guard let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: VideoViewCell.identifier,
				for: indexPath
			) as? VideoViewCell else {
				return UICollectionViewCell()
			}
			let videoData = presenter.getVideo(at: indexPath.item)
			cell.configure(imageUrl: videoData.urlPrev, title: videoData.title)
			
			return cell
		}
	}
}

extension GalleryViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch collectionView.tag {
		case 1:
			presenter.fotoDidSelect(at: indexPath.item)
		default:
			presenter.videoDidSelect(at: indexPath.item)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if collectionView.tag == 1,
		   presenter.getCountFotos() > 0,
		   indexPath.item == presenter.getCountFotos() - 4 {
			presenter.fetchFoto()
		}
	}
}

extension GalleryViewController: IGalleryView {
	func reloadFotoCollection() {
		contentView.fotoCollectionView.reloadData()
	}
	func reloadVideoCollection() {
		contentView.videoCollectionView.reloadData()
	}
}

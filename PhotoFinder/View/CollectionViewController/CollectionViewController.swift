//
//  CollectionViewController.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 13.11.2022.
//

import UIKit
import Alamofire


class CollectionViewController: UICollectionViewController {
    
    var viewModel: CollectionViewModelProtocol?
    
    var detailViewModel: DetailViewModelProtocol?
    
    var activityIndicator: UIActivityIndicatorView!
    
    var recognizer: UILongPressGestureRecognizer!
    
    var footerIsHidden: Bool = true
    
    var imageMenu = UIMenu()
    
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel = DetailViewModel()
        setupImageMenu()
        addObserverForTouchSearchButton()
        addObserverForErrorSearch()
        addObserverForOverButtonLoadPressed()
        viewModel = CollectionViewModel()
        addRecognizer()
        registerView()
        setActivityIndicator()
        
        
    }
  
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        viewModel?.setOfCell(cell: cell, with: indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDataSource Header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! CollectionViewHeader
            return view
        case UICollectionView.elementKindSectionFooter:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as! CollectionViewFooter
            view.isHidden = footerIsHidden
            return view
        default:
            return UICollectionReusableView()
//            assert(false, "Unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
    }
    
    
    // MARK: - UICollectionViewDelegate
    // Отслеживание поворота экрана
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailPhotoVC", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        if segue.identifier == "toDetailPhotoVC" {
            let vc = segue.destination as? DetailPhotoViewController
            let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell
            vc?.image = cell?.imageView.image
        }
    }
    
    @objc private func longPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
        }
    }
    
    private func addRecognizer() {
        recognizer = UILongPressGestureRecognizer()
        recognizer.addTarget(self, action: #selector(longPress))
        view.addGestureRecognizer(recognizer)
    }
}






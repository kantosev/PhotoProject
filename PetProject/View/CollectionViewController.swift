//
//  CollectionViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 13.11.2022.
//

import UIKit
import Alamofire

class CollectionViewController: UICollectionViewController {
    
    private var viewModel: CollectionViewModelProtocol?

    var activityIndicator: UIActivityIndicatorView!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserverForTouchSearchButton()
        addObserverForErrorSearch()
        viewModel = CollectionViewModel()
        registerView()
        setActivityIndicator()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel?.numberOfItemsInSection() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        viewModel?.setOfCell(cell: cell, with: indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDataSource Header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! CollectionViewHeader
        return view
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    
   
}

// MARK: - UICollectionViewDelegateFlowLayout


// MARK: - Observer
extension CollectionViewController {
    @objc func searchButtonPressed(notification: Notification) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        guard let userInfo = notification.userInfo else { return }
        guard let text = userInfo["text"] as? String else { return }
        viewModel?.fetchOfData(with: text) {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    @objc func errorSearch() {
        AlertController.showAlertController(onViewController: self, title: "Error", message: "Вы ничего не ввели")
    }
    
}

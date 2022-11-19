//
//  CollectionViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 13.11.2022.
//

import UIKit
import Alamofire

private let cellID = "PhotoCell"

class CollectionViewController: UICollectionViewController {
    
    private var viewModel: CollectionViewModelProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CollectionViewModel()
        viewModel?.fetchOfData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout?.minimumLineSpacing = 10
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel?.numberOfItemsInSection() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        viewModel?.setOfCell(cell: cell, with: indexPath)
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate
    
    
    
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


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    // layout.itemSize почему то не работает, поэтому использую метод делегата
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 2 - 10 - 5
        return CGSize(width: width, height: width)
    }
}

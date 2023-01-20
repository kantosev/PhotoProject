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
    
    var recognizer: UILongPressGestureRecognizer!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserverForTouchSearchButton()
        addObserverForErrorSearch()
        viewModel = CollectionViewModel()
        recognizer = UILongPressGestureRecognizer()
        recognizer.addTarget(self, action: #selector(longPress))
        view.addGestureRecognizer(recognizer)
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
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! CollectionViewHeader
        
        return view
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
    
   
}

// MARK: - Observer
extension CollectionViewController {
    @objc func searchButtonPressed(notification: Notification) {
        view.endEditing(true)
        if NetworkMonitor.shared.isConnected == true {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
            guard let userInfo = notification.userInfo else { return }
            guard let text = userInfo["text"] as? String else { return }
            viewModel?.fetchOfData(with: text, completion: { [activityIndicator, collectionView] arrayIsEmpty in
                activityIndicator?.stopAnimating()
                if arrayIsEmpty == false {
                    collectionView?.reloadData()
                } else {
                    AlertController.showAlertController(onViewController: self, title: "Ошибка", message: "Изображений по запросу не найдено")
                }
            }, errorCompletion: { [activityIndicator] error in
                AlertController.showAlertController(onViewController: self, title: "Ошибка загрузки данных", message: "Данные не были загружены, попробуйте позже")
                activityIndicator?.stopAnimating()
            })
        } else {
            AlertController.showAlertController(onViewController: self, title: "Ошибка соединения", message: "Нет соединения с интернетом")
        }
    }
    @objc func errorSearch() {
        AlertController.showAlertController(onViewController: self, title: "Error", message: "Вы ничего не ввели")
    }
    
    @objc private func longPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            
        }
    }
}


extension CollectionViewController: UITextFieldDelegate {
    // нажатие кнопки return на клавиатуре обрабатывается
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
//        textField.resignFirstResponder()
        return true
    }
    
   
    
}

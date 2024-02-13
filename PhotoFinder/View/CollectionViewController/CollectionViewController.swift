//
//  CollectionViewController.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 13.11.2022.
//

import UIKit
import Alamofire


/// Основной экран приложения (CollectionView)
final class CollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    // View model CollectionVC
    var viewModel: CollectionViewModelProtocol?
    // View model DetailPhotoVC
    var detailViewModel: DetailViewModelProtocol?
    // Индикатор загрузки
    var activityIndicator: UIActivityIndicatorView!
    // Показан ли Footer
    var footerIsHidden: Bool = true
    // Меню, открывающееся по длительному нажатию на фото
    var imageMenu: UIMenu?
    // Изображение для детального открытия
    var image: UIImage?
    
    // MARK: - init()
    
    required init?(coder: NSCoder) {
        self.viewModel = CollectionViewModel()
        self.detailViewModel = DetailViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageMenu()
        addObserverForTouchSearchButton()
        addObserverForErrorSearch()
        addObserverForOverButtonLoadPressed()
        registerView()
        setActivityIndicator()
    }
    
    // MARK: - UICollectionViewDataSource
    
    /// Число ячеек в секции
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }
    
    /// Возвращает саму ячейку
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        viewModel?.setOfCell(cell: cell, with: indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDataSource (Kind)
    
    /// Создание kind item (Header + Footer)
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
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    /// Отслеживание поворота экрана
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    
    /// Действие по выбору ячейки
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailPhotoVC", sender: indexPath)
    }
    
    /// Вызывается в момент срабатывания перехода (непосредственно перед переходом на новую сцену)
    /// - Parameters:
    ///   - segue: Сработавший переход
    ///   - sender: Элемент. вызвавший segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        if segue.identifier == "toDetailPhotoVC" {
            let vc = segue.destination as? DetailPhotoViewController
            let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell
            vc?.image = cell?.imageView.image
        }
    }
    
}






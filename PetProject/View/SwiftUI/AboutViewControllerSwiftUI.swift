//
//  AboutViewControllerSwiftUI.swift
//  PetProject
//
//  Created by Антон Кирилюк on 17.12.2022.
//

import SwiftUI

class AboutViewControllerSwiftUI: UIViewController {
    
    private var signManager: SignManagerProtocol?
    
    private let hostingViewController = UIHostingController(rootView: AboutView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signManager = SignManager()
        setDismissCompletion()
        setDeleteAccountCompletion()
        addVC()
        setupConstraint()
    }
  
    
    private func setupConstraint() {
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func addVC() {
        addChild(hostingViewController)
        view.addSubview(hostingViewController.view)
    }
    private func setDismissCompletion() {
        hostingViewController.rootView.dismiss = {
            self.signManager?.logOut(successCompletion: {
                self.navigationController?.popToRootViewController(animated: true)
            }, errorCompletion: { error in
                AlertController.showAlertController(onViewController: self, title: "Error", message: "Ошибка изменения данных")
            })
        }
    }
    private func setDeleteAccountCompletion() {
        hostingViewController.rootView.deleteAccountCompletion = {
            self.signManager?.deleteAccount(
                successCompletion: {
                    AlertController.showAlertController(onViewController: self, title: "Успешно", message: "Аккаунт удален") {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }, errorCompletion: { error in
                    print(error.localizedDescription)
                    AlertController.showAlertController(onViewController: self, title: "Ошибка", message: " Ошибка удаления аккаунта")
                })
        }
    }
    
    //    required init?(coder aDecoder: NSCoder){
    //        super.init(coder: aDecoder, rootView: AboutView())
    //    }
    
    
}

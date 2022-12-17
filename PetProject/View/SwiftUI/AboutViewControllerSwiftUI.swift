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
        hostingViewController.rootView.dismiss = {
            self.signManager?.logOut(successCompletion: {
                self.navigationController?.popToRootViewController(animated: true)
            }, errorCompletion: { error in
                AlertController.showAlertController(onViewController: self, title: "Error", message: "\(error)")
            })
        }
        addChild(hostingViewController)
        view.addSubview(hostingViewController.view)
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
    
    //    required init?(coder aDecoder: NSCoder){
    //        super.init(coder: aDecoder, rootView: AboutView())
    //    }
    
    
}

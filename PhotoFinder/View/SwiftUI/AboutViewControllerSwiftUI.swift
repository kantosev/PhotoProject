//
//  AboutViewControllerSwiftUI.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 17.12.2022.
//

import SwiftUI

class AboutViewControllerSwiftUI: UIViewController {
    
    private let hostingViewController = UIHostingController(rootView: AboutView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
 
    
    
    //    required init?(coder aDecoder: NSCoder){
    //        super.init(coder: aDecoder, rootView: AboutView())
    //    }
    
    
}

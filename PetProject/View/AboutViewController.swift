//
//  AboutViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 05.11.2022.
//

import UIKit

class AboutViewController: UIViewController {

    private var signManager: SignManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signManager = SignManager()
    }
    
   

    
    @IBAction func logOutButtonAction(_ sender: Any) {
        print(User.current?.authData)
        signManager?.logOut(onViewController: self) {
            self.navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

}

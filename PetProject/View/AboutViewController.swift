//
//  AboutViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 05.11.2022.
//

import UIKit

class AboutViewController: UIViewController {

    private var signManager: SignManagerProtocol?
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signManager = SignManager()
        userNameLabel.text = User.current?.username
        
    }
    
   

    
    @IBAction func logOutButtonAction(_ sender: Any) {
        signManager?.logOut(onViewController: self) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    

}

//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Антон Кирилюк on 17.12.2022.
//

import SwiftUI

struct AboutView: View {
    
    
    private var signManager: SignManagerProtocol? = SignManager()
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea()
            
            VStack {
//                RowView(text1: "Имя", text2: String(describing: (User.current?.username)!))
//                RowView(text1: "email", text2: String(describing: (User.current?.email)!))
//                RowView(text1: "Возраст", text2: String(describing: (User.current?.age)!))
                RowView(text1: "Имя", text2: "")
                RowView(text1: "email", text2: "")
                RowView(text1: "Возраст", text2: "")
                Spacer()
                Button("Выйти из аккаунта") {
                    signManager?.logOut(onViewController: self) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
            
        }
    }
        
}

struct AboutView_SwiftUI__Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

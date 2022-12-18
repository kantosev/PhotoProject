//
//  UpdateAccountScreenView.swift
//  PetProject
//
//  Created by Антон Кирилюк on 18.12.2022.
//

import SwiftUI

struct UpdateAccountScreenView: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var age: String = ""
    
    private var signManager: SignManagerProtocol? = SignManager()
    
    var body: some View {
        VStack {
            TextFieldView(text: $userName, placeholder: Text("Введите новое имя пользователя"))
            TextFieldView(text: $email, placeholder: Text("Введите новый email"))
            TextFieldView(text: $age, placeholder: Text("Введите новый возраст"))
            Spacer()
        }
        .toolbar {
            Button("Save") {
                signManager?.updateAccount(userName: userName, email: email, age: age, successCompletion: {
                    #warning("Данные обновляются, но надо вернуться на пред. экран и обновить там данные")
                }, errorCompletion: { error in
                    
                })
            }
        }
           
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        
    }
}

struct UpdateAccountScreenView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateAccountScreenView()
    }
}

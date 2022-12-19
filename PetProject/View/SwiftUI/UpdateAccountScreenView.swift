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
    
    @Environment(\.dismiss) var dismiss
    
    private var signManager: SignManagerProtocol? = SignManager()
    
    var body: some View {
        VStack {
            TextFieldView(textFieldText: $userName, placeholder: Text("Введите новое имя пользователя"))
            TextFieldView(textFieldText: $email, placeholder: Text("Введите новый email"))
            TextFieldView(textFieldText: $age, placeholder: Text("Введите новый возраст"))
            Spacer()
        }
        .toolbar {
            Button("Save") {
                dismiss()
                signManager?.updateAccount(userName: userName, email: email, age: age, successCompletion: {
                    #warning("обновить данные на пред. экране")
                }, errorCompletion: { error in
                    print(error.localizedDescription)
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

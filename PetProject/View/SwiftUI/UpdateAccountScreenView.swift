//
//  UpdateAccountScreenView.swift
//  PetProject
//
//  Created by Ivan Eremeev on 18.12.2022.
//

import SwiftUI

struct UpdateAccountScreenView: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var renameDataSuccessful: Bool = false
    @State private var renameDataError: Bool = false
    @State private var allisEmptyMarker = false
    
    @Environment(\.dismiss) var dismiss
    
    private var signManager: SignManagerProtocol? = SignManager()
    
    var body: some View {
        VStack {
            TextFieldView(textFieldText: $userName, placeholder: Text("Enter new login"))
            TextFieldView(textFieldText: $email, placeholder: Text("Enter new email"))
            Spacer()
        }
        .toolbar {
            Button("Save") {
                guard let user = User.current?.username else { renameDataError.toggle()
                    return
                }
                if userName.isEmpty && email.isEmpty {
                    allisEmptyMarker.toggle()
                } else {
                    signManager?.updateAccount(userName: userName, email: email, successCompletion: {
                        DispatchQueue.main.async {
                            dismiss()
                        }
                        renameDataSuccessful.toggle()
                        guard let backgroundColor = UserDefaults.standard.object(forKey: user) as? [CGFloat] else { return }
                        UserDefaults.standard.set(backgroundColor, forKey: userName)
                    }, errorCompletion: { error in
                        print(error.localizedDescription)
                        renameDataError.toggle()
                    })
                }
            }
            .alert("You haven't entered anything", isPresented: $allisEmptyMarker) {}
            .alert("Account information has been updated successfully", isPresented: $renameDataSuccessful) {}
            .alert("Mistake. The data has not been changed", isPresented: $renameDataError) { }
            
        }
           
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        
    }
}

struct UpdateAccountScreenView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateAccountScreenView()
    }
}

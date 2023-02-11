//
//  TextFieldView.swift
//  PetProject
//
//  Created by Ivan Eremeev on 18.12.2022.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var textFieldText: String
    let placeholder: Text
    
    var body: some View {
        TextField("", text: $textFieldText, prompt: placeholder)
            .frame(height: 40)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            .border(.blue)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            

    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(textFieldText: .constant(""), placeholder: Text("Введите имя"))
    }
}

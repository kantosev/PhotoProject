//
//  TextFieldView.swift
//  PetProject
//
//  Created by Антон Кирилюк on 18.12.2022.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        TextField("", text: $text, prompt: placeholder)
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
        TextFieldView(text: .constant(""), placeholder: Text("Введите имя"))
    }
}

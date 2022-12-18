//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Антон Кирилюк on 17.12.2022.
//

import SwiftUI

struct AboutView: View {
    @State private var backgroundColor: Color = .white
    
    var dismiss: (() -> Void)?
    
    var deleteAccountCompletion: (() -> Void)?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    RowView(text1: "Имя", text2: String(describing: (User.current?.username)!))
                    RowView(text1: "email", text2: String(describing: (User.current?.email)!))
                    RowView(text1: "Возраст", text2: String(describing: (User.current?.age)!))
//                    RowView(text1: "Имя", text2: "")
//                    RowView(text1: "email", text2: "")
//                    RowView(text1: "Возраст", text2: "")
                    NavigationLink(destination: UpdateAccountScreenView()) {
                        Text("Изменить данные аккаунта")
                    }
                        
                    Spacer()
                    ColorPickerView(bgColor: $backgroundColor)
                    Spacer()
                    Button("Выйти из аккаунта") {
                        self.dismiss?()
                    }
                    Button("Удалить аккаунт") {
                        self.deleteAccountCompletion?()
                    }
                    .foregroundColor(.red)
                    .padding()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                }
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            }
            .background(backgroundColor)
        }
    }
}

struct AboutView_SwiftUI__Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

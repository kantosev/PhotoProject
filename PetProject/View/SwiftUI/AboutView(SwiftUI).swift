//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Антон Кирилюк on 17.12.2022.
//

import SwiftUI

struct AboutView: View {
    @State private var backgroundColor: Color = .white
   
    @State private var name: String = (User.current?.username)!
    @State private var email: String = (User.current?.email)!
    @State private var age: String = (User.current?.age)!
    
    @State private var connected: Bool = !(NetworkMonitor.shared.isConnected)
    
    var dismiss: (() -> Void)?
    
    var deleteAccountCompletion: (() -> Void)?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    RowView(text1: "Имя", text2: $name)
                        .onAppear {
                            guard let userName = User.current?.username else { return }
                            name = userName
                        }
                    RowView(text1: "email", text2: $email)
                        .onAppear {
                            guard let userEmail = User.current?.email else { return }
                            email = userEmail
                        }
                    RowView(text1: "Возраст", text2: $age)
                        .onAppear {
                            guard let userAge = User.current?.age else { return }
                            age = userAge
                        }
//                    RowView(text1: "Имя", text2: "")
//                    RowView(text1: "email", text2: $name)
//                    RowView(text1: "Возраст", text2: $name)
                    NavigationLink(destination: UpdateAccountScreenView()) {
                        Text("Изменить данные аккаунта")
                    }
                    Spacer()
                    ColorPickerView(bgColor: $backgroundColor)
                        .onChange(of: backgroundColor) { _ in
                            let color = backgroundColor.cgColor
                            guard let colorComponents = color?.components else { return }
                            guard let user = User.current?.username else { return }
                            UserDefaults.standard.set(colorComponents, forKey: user)
                        }
                        .onAppear {
                            guard let user = User.current?.username else { return }
                            guard let colorComponent = UserDefaults.standard.object(forKey: user) as? [CGFloat] else { return }
                            let color = CGColor(red: colorComponent[0], green: colorComponent[1], blue: colorComponent[2], alpha: colorComponent[3])
                            backgroundColor = Color(cgColor: color)
                           
                            
                        }
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
        .alert("Нет интернета", isPresented: $connected) {
            
        }
            }
        
}

struct AboutView_SwiftUI__Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

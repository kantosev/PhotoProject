//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Ivan Eremeev on 17.12.2022.
//

import SwiftUI
import ActivityIndicatorView

struct AboutView: View {
    @State private var backgroundColor: Color = .white
    
    @State private var name: String = (User.current?.username)!
    @State private var email: String = (User.current?.email)!
    @State private var visibleActivityIndicator: Bool = false
    
    var dismiss: (() -> Void)?
    
    @State private var connected: Bool = false
    
    var deleteAccountCompletion: (() -> Void)?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    RowView(text1: "Name", text2: $name)
                        .onAppear {
                            guard let userName = User.current?.username else { return }
                            name = userName
                        }
                    RowView(text1: "Email", text2: $email)
                        .onAppear {
                            guard let userEmail = User.current?.email else { return }
                            email = userEmail
                        }
                    NavigationLink(destination: UpdateAccountScreenView()) {
                        Text("Change account details")
                        
                    }
                    .buttonStyle(.borderedProminent)
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
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 70, trailing: 0))
                    
                    ActivityIndicatorView(isVisible: $visibleActivityIndicator, type: .rotatingDots())
                        .foregroundColor(.red)
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    
                    Spacer()
                    Button("Log Out") {
                        self.dismiss?()
                        visibleActivityIndicator.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Delete account") {
                        self.deleteAccountCompletion?()
                        visibleActivityIndicator.toggle()
                    }
                    
                    .foregroundColor(.red)
                    .padding()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                }
                
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            }
            .onAppear {
                if !NetworkMonitor.shared.isConnected {
                    connected = true
                }
            }
            .background(backgroundColor)
            .alert("lost internet connection", isPresented: $connected) {}
        }
    }
    
}

struct AboutView_SwiftUI__Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

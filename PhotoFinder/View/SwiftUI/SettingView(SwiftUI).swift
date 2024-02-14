//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Anton Kirilyuk on 17.12.2022.
//

import SwiftUI
import Foundation


/// Объект, содержащий варианты размеров загружаемых изображений
enum ProfileSection : String, CaseIterable {
    case small = "1"
    case med = "2"
    case big = "3"
    case lrg = "4"
}

/// Экран настроек
struct SettingView: View {
    
    // Запись выбранного размера в UserDefaults
    init() {
        // Окрас UISegmentedControl
        if #available(iOS 15.0, *) {
            UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
        } else {
            UISegmentedControl.appearance().selectedSegmentTintColor = .gray
        }
        
    }
    
    @AppStorage("sizeImage") var sizeImage: ProfileSection = ProfileSection.med
    
    var body: some View {
        
        VStack {
            // MARK: - Picker
            Text("Quality of uploaded images")
                .padding(EdgeInsets(top: 60, leading: 5, bottom: 0, trailing: 5))
            // Выбор размера изображения
            Picker("", selection: $sizeImage) {
                ForEach(ProfileSection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(EdgeInsets(top: 10, leading: 8, bottom: 40, trailing: 8))
            
            // MARK: - Contact Button
            if #available(iOS 15.0, *) {
                Button("Contact the developers") {
                    if let url = URL(string: "mailto:kantosev2@gmail.com") {
                        UIApplication.shared.open(url)
                    }
                }
                .buttonStyle(.bordered)
            } else {
                Button("Contact the developers") {
                    if let url = URL(string: "mailto:kantosev2@gmail.com") {
                        UIApplication.shared.open(url)
                    }
                }
            }
            Spacer()
        }
    }
    
}

#Preview {
    SettingView()
}


   

//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Ivan Eremeev on 17.12.2022.
//

import SwiftUI

enum ProfileSection : String, CaseIterable {
    case thumb = "Min"
    case small = "Небольшой"
    case regular = "Средний"
    case full = "Большой"
    case raw = "Max"
}

struct AboutView: View {
    
    init() {
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("thumb", forKey: "sizeImage")
        }), forSegmentAt: 0)
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("small", forKey: "sizeImage")
        }), forSegmentAt: 1)
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("regular", forKey: "sizeImage")
        }), forSegmentAt: 2)
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("full", forKey: "sizeImage")
        }), forSegmentAt: 3)
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("raw", forKey: "sizeImage")
        }), forSegmentAt: 4)
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemCyan
        
    }
    
    @State private var visibleActivityIndicator: Bool = false
    @State private var connected: Bool = false
    @State var segmentationSelection : ProfileSection = .regular
    
    var body: some View {
        
        VStack {
            Text("Качество загружаемых изображений")
                .padding(EdgeInsets(top: 20, leading: 5, bottom: 0, trailing: 5))
            Picker("", selection: $segmentationSelection) {
                ForEach(ProfileSection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Spacer()
        }
    }
    
}

struct AboutView_SwiftUI__Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}


//    .onAppear {
//        if !NetworkMonitor.shared.isConnected {
//            connected = true
//        }
//    }
//    .alert("lost internet connection", isPresented: $connected) {}

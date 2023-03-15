//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Ivan Eremeev on 17.12.2022.
//

import SwiftUI
import Foundation

enum ProfileSection : String, CaseIterable {
    case thumb = "1"
    case small = "2"
    case regular = "3"
    case full = "4"
    case raw = "5"
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
        
        if #available(iOS 15.0, *) {
            UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
        } else {
            UISegmentedControl.appearance().selectedSegmentTintColor = .gray
        }
        
    }
    
    @State private var visibleActivityIndicator: Bool = false
    @State private var connected: Bool = false
    @State var segmentationSelection : ProfileSection = .regular
    
    var body: some View {
        
        VStack {
            Text("Quality of uploaded images")
                .padding(EdgeInsets(top: 60, leading: 5, bottom: 0, trailing: 5))
            Picker("", selection: $segmentationSelection) {
                ForEach(ProfileSection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(EdgeInsets(top: 10, leading: 1, bottom: 40, trailing: 1))
            
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

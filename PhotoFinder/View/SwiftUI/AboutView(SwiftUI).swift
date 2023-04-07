//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Anton Kirilyuk on 17.12.2022.
//

import SwiftUI
import Foundation

enum ProfileSection : String, CaseIterable {
    case small = "1"
    case med = "2"
    case big = "3"
    case lrg = "4"
}

struct AboutView: View {
    
    init() {
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("1", forKey: "sizeImage")
        }), forSegmentAt: 0)
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("2", forKey: "sizeImage")
        }), forSegmentAt: 1)
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("3", forKey: "sizeImage")
        }), forSegmentAt: 2)
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("4", forKey: "sizeImage")
        }), forSegmentAt: 3)
        
        
        if #available(iOS 15.0, *) {
            UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
        } else {
            UISegmentedControl.appearance().selectedSegmentTintColor = .gray
        }
        
    }
    
    @State private var visibleActivityIndicator: Bool = false
    @State private var connected: Bool = false
    @State var segmentationSelection : ProfileSection = ProfileSection(rawValue: UserDefaults.standard.string(forKey: "sizeImage") ?? "2")! 
    
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
            .padding(EdgeInsets(top: 10, leading: 8, bottom: 40, trailing: 8))
            
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

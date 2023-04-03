//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Anton Kirilyuk on 17.12.2022.
//

import SwiftUI
import StoreKit

enum ProfileSection : String, CaseIterable {
    case small = "1"
    case med = "2"
    case big = "3"
    case lrg = "4"
    case huge = "5"
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
        UISegmentedControl.appearance().setAction(UIAction(handler: { _ in
            UserDefaults.standard.set("5", forKey: "sizeImage")
        }), forSegmentAt: 4)
        
        if #available(iOS 15.0, *) {
            UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
        } else {
            UISegmentedControl.appearance().selectedSegmentTintColor = .gray
        }
        
    }
    @State var segmentationSelection : ProfileSection = ProfileSection(rawValue: UserDefaults.standard.string(forKey: "sizeImage") ?? "2")!
    
    private let productIds = ["com.PhotoApp.support"]
    @State private var products: [Product] = []
    
    @StateObject private var purchaseManager = PurchaseManager()
    
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
            // Кнопка покупки
            ForEach(purchaseManager.products) { product in
                Button {
                    Task {
                        do {
                            try await purchaseManager.purchase(product)
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("\(product.displayPrice) - \(product.displayName)")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(Capsule())
                }
            }
            
            
            Spacer()
            // эта функция вызывается, когда наше вью появляется с помощью .task()
        }.task {
            do {
                try await purchaseManager.loadProducts()
            } catch {
                print(error)
            }
        }
    }
}

struct AboutView_SwiftUI__Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}


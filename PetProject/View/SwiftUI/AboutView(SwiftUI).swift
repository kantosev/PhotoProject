//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Ivan Eremeev on 17.12.2022.
//

import SwiftUI
import ActivityIndicatorView

struct AboutView: View {
    @State private var visibleActivityIndicator: Bool = false
    
    @State private var connected: Bool = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                   
                }
            }
            .onAppear {
                if !NetworkMonitor.shared.isConnected {
                    connected = true
                }
            }
            .alert("lost internet connection", isPresented: $connected) {}
        }
    }
    
}

struct AboutView_SwiftUI__Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

//
//  AboutView(SwitUI).swift
//  PetProject
//
//  Created by Антон Кирилюк on 17.12.2022.
//

import SwiftUI

struct AboutView_SwiftUI_: View {
    
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.2)
                .ignoresSafeArea()
            VStack {
                Text("\(String(describing: User.current?.username))")
                Text("\(String(describing: User.current?.email))")
                Text("\(String(describing: User.current?.age))")
                Text("\(String(describing: User.current?.emailVerified))")
            }
        }
        
    }
        
}

struct AboutView_SwiftUI__Previews: PreviewProvider {
    static var previews: some View {
        AboutView_SwiftUI_()
    }
}

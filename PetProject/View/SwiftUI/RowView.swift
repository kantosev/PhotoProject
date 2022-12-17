//
//  RowView.swift
//  PetProject
//
//  Created by Антон Кирилюк on 17.12.2022.
//

import SwiftUI

struct RowView: View {
    let text1: String
    let text2: String
    
    var body: some View {
        HStack {
            Text("\(text1)")
            Spacer()
            Text(text2)
        }
        .padding()
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(text1: "Имя пользователя", text2: "username")
    }
}

//
//  Experiment.swift
//  PetProject
//
//  Created by Антон Кирилюк on 18.12.2022.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var bgColor: Color
    
    var body: some View {
        ColorPicker("Выберите цвет фона", selection: $bgColor)
            .foregroundColor(.black)
            .frame(width: 220)
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(bgColor: .constant(.red))
    }
}

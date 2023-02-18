//
//  Experiment.swift
//  PetProject
//
//  Created by Ivan Eremeev on 18.12.2022.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var bgColor: Color
    
    var body: some View {
        ColorPicker("Choose background color", selection: $bgColor)
            .foregroundColor(.black)
            .frame(width: 240)
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(bgColor: .constant(.red))
    }
}

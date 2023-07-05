//
//  CustomTextFieldView.swift
//  TextFieldBugs
//
//  Created by Wojciech Kulik on 03/06/2023.
//

import SwiftUI

struct CustomTextFieldView: UIViewRepresentable {
    var text: Binding<String>

    func makeUIView(context: Context) -> CustomTextField {
        let textField = CustomTextField()
        textField.placeholder = "Empty Field"
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .numberPad

        return textField
    }

    func updateUIView(_ uiView: CustomTextField, context: Context) {}
}

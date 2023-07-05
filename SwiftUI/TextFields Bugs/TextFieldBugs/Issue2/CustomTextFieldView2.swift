//
//  CustomTextField2.swift
//  TextFieldBugs
//
//  Created by Wojciech Kulik on 04/06/2023.
//

import SwiftUI

struct CustomTextFieldView2: UIViewRepresentable {
    static var didBecomeFirstResponder = false

    var text: Binding<String>

    func makeUIView(context: Context) -> CustomTextField {
        let textField = CustomTextField()
        textField.placeholder = "Empty Field"
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no

        // remove the line below to fix the issue ¯\_(ツ)_/¯
        textField.keyboardType = .numberPad

        // Also, if you disable in Settings -> Passwords -> Password Options -> AutoFill Passwords
        // the issue won't be reproducible. Based on memory graph there is some problem with autofill holding
        // the reference to this text field.

        // It looks like calling "becomeFirstResponder" before the text field is visible
        // is causing this issue.
        DispatchQueue.main.async {
            guard !Self.didBecomeFirstResponder else { return }
            Self.didBecomeFirstResponder = true

            textField.becomeFirstResponder()
        }

        return textField
    }

    func updateUIView(_ uiView: CustomTextField, context: Context) {}
}

//
//  CustomTextField.swift
//  TextFieldBugs
//
//  Created by Wojciech Kulik on 04/06/2023.
//

import UIKit

final class CustomTextField: UITextField {
    init() {
        super.init(frame: .zero)
        print("init text field")
    }

    deinit { print("deinit text field") }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        super.canPerformAction(action, withSender: sender)
    }
}

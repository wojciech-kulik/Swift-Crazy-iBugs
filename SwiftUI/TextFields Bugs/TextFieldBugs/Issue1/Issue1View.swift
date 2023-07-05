//
//  Issue1View.swift
//  TextFieldBugs
//
//  Created by Wojciech Kulik on 03/06/2023.
//

import SwiftUI

struct Issue1View: View {
    @Binding var text: String

    var body: some View {
        VStack(spacing: 24) {
            // Custom text fields are not necessary here, but it's easier to track them on memory graph. Alternatively:
            // TextField("Empty Field", text: .constant(""))
            // TextField("Empty Field", text: .constant(""))

            CustomTextFieldView(text: $text).fixedSize(horizontal: false, vertical: true)
            // remove the second text field to fix the memory leak... ¯\_(ツ)_/¯
            CustomTextFieldView(text: $text).fixedSize(horizontal: false, vertical: true)
            Spacer()
            Text("Reproducible on simulator with iOS 15.5 and iOS 16.4.").foregroundColor(.gray)
            Text("Tap once on the first text field to activate the keyboard and go back to the first screen.")
            Text("In memory graph you will see that CustomTextFields and ViewModel(only iOS 16) are still in memory.")
        }
        .font(.system(size: 14.0))
        .padding()
        .multilineTextAlignment(.center)
        .padding(.top, 24)
        .navigationTitle("Issue 1")
        .navigationBarTitleDisplayMode(.inline)
    }
}

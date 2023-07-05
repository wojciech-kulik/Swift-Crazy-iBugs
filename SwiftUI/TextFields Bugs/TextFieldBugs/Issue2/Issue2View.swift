//
//  Issue2View.swift
//  TextFieldBugs
//
//  Created by Wojciech Kulik on 04/06/2023.
//

import SwiftUI

struct Issue2View: View {
    @State var text = "123"
    @State var areFieldsVisible = false

    var body: some View {
        VStack(spacing: 24) {
            if areFieldsVisible {
                CustomTextFieldView2(text: $text).fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            Text("Reproducible on simulator: iOS 14.5, iOS 15.5, iOS 16.4 and physical device with iOS 14.1 and 16.5.").foregroundColor(.gray)
            Text("Do nothing here and go back to the first screen.")
            Text("In memory graph you will see that UIKBAutofillController is holding the reference to CustomTextField and the control is not released.")
        }
        .font(.system(size: 14.0))
        .padding()
        .multilineTextAlignment(.center)
        .animation(.easeInOut) // This issue is caused by the animation. Remove this line to fix it. ¯\_(ツ)_/¯
        .onAppear {
            guard !areFieldsVisible else { return }

            Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                areFieldsVisible = true
            }
        }
        .padding(.top, 24)
        .navigationTitle("Issue 2")
        .navigationBarTitleDisplayMode(.inline)
    }
}

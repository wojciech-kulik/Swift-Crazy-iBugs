//
//  ViewWithViewModel.swift
//  TextFieldBugs
//
//  Created by Wojciech Kulik on 03/06/2023.
//

import SwiftUI

final class ViewModel: ObservableObject {
    @Published var text: String = ""

    init() { print("init ViewModel") }
    deinit { print("deinit ViewModel") }
}

struct ViewWithViewModel<VM: ViewModel>: View {
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack {
            NavigationLink("Next Screen") {
                Issue1View(text: $viewModel.text)
            }
        }
        .padding()
        .navigationTitle("Issue 1")
        .navigationBarTitleDisplayMode(.inline)
    }
}

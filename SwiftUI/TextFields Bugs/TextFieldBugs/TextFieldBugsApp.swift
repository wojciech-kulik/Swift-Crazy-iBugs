//
//  TextFieldBugsApp.swift
//  TextFieldBugs
//
//  Created by Wojciech Kulik on 03/06/2023.
//

import SwiftUI

@main
struct TextFieldBugsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack(spacing: 48) {
                    NavigationLink("Issue 1") { LazyIssue1() }
                    NavigationLink("Issue 2") { LazyIssue2() }
                }
                .navigationTitle("TextField Bugs")
                // Adding the line below resolves the second issue on iOS 14.5 ¯\_(ツ)_/¯
//                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct LazyIssue1: View {
    @State var content: ViewWithViewModel<ViewModel>?

    var body: some View {
        if let content {
            content
        } else {
            Text("Loading").onAppear {
                content = ViewWithViewModel(viewModel: .init())
            }
        }
    }
}

struct LazyIssue2: View {
    @State var content: Issue2View?

    var body: some View {
        if let content {
            content
        } else {
            Text("Loading").onAppear {
                content = Issue2View()
            }
        }
    }
}

//
//  ViewController.swift
//  TextViewBug
//
//  Created by Wojciech Kulik on 19/08/2023.
//

import Cocoa

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // To reproduce the bug set cursor in the first line and hit & press enter.
        // The second line will be drawn with lag. Then hit & press backspace.

        setup(bug: true)
//        setup(bug: false)
//        bugAlternative()
//        textKit2NoBug()
    }

    private func setup(bug: Bool) {
        let scrollView = NSTextView.scrollableTextView()
        let textView = (scrollView.documentView as? NSTextView)!

        // The case that presents the bug:
        textView.string = "\naaaaa\nbbbbbb"
        textView.setSelectedRange(.init(location: 0, length: 0))

        if bug {
            // accessing this field breaks rendering
            // because is triggers switching from TextKit 2 to TextKit 1
            _ = textView.layoutManager
        }

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bugAlternative() {
        let textContainer = NSTextContainer()
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true

        let layoutManager = NSLayoutManager()
        let textStorage = NSTextStorage(string: "")

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        let textView = NSTextView(frame: .zero, textContainer: textContainer)
        textView.autoresizingMask = [.width, .height]

        // The case that presents the bug:
        textView.string = "\naaaaa\nbbbbbb"
        textView.setSelectedRange(.init(location: 0, length: 0))

        let scrollView = NSScrollView()
        scrollView.documentView = textView
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func textKit2NoBug() {
        let textView = NSTextView(usingTextLayoutManager: true)
        textView.autoresizingMask = [.width, .height]

        // The case that presents the bug:
        textView.string = "\naaaaa\nbbbbbb"
        textView.setSelectedRange(.init(location: 0, length: 0))

        let scrollView = NSScrollView()
        scrollView.documentView = textView
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

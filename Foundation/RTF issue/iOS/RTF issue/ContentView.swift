//
//  ContentView.swift
//  RTF issue
//
//  Created by Wojciech Kulik on 29/01/2025.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    let rtfData = #"""
    {\rtf1\ansi\ansicpg1252\cocoartf2821
    \cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fswiss\fcharset0 Helvetica-Bold;}
    {\colortbl;\red255\green255\blue255;}
    {\*\expandedcolortbl;;}
    {\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid1\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid1}}
    {\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}}
    \deftab720
    \pard\pardeftab720\sa240\partightenfactor0
    
    \f0\fs20 \cf0 \expnd0\expndtw0\kerning0
    Hi \
    Thank you for your interest in working with me. Some of my pricing details are below:\
    \pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
    \ls1\ilvl0
    \f1\b \cf0 {\listtext    \uc0\u8226     }Pricing:
    \f0\b0  Something}
    """#.data(using: .utf8)!

    var body: some View {
        VStack {
            Text("Expected Result:")
            RichTextEditor(text: try! .init(
                data: rtfData,
                options: [.documentType: NSAttributedString.DocumentType.rtf],
                documentAttributes: nil
            ))
            .frame(height: 300)
            .frame(maxWidth: .infinity)

            Button("Copy HTML to Clipboard") {
                let html = (try! NSAttributedString(
                    data: rtfData,
                    options: [.documentType: NSAttributedString.DocumentType.rtf],
                    documentAttributes: nil
                )).html!

                UIPasteboard.general.setItems([
                    [UTType.html.identifier: html]
                ])

                print(html)
            }.padding(.vertical)

            Text("Paste Content Below:")

            RichTextEditor()
                .frame(height: 300)
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

struct RichTextEditor: UIViewRepresentable {
    var text: NSAttributedString?

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.allowsEditingTextAttributes = true
        textView.backgroundColor = UIColor.lightGray
        textView.font = UIFont.preferredFont(forTextStyle: .body)

        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            print(text != nil ? "\n\nBEFORE PASTING:" : "\n\nAFTER PASTING:")
            print(String(data: try! textView.attributedText.data(
                from: .init(location: 0, length: textView.attributedText.length),
                documentAttributes: [.documentType: NSAttributedString.DocumentType.html]
            ), encoding: .utf8)!)
        }


        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        if let text {
            textView.attributedText = text
        }
    }
}

extension NSAttributedString {
    var html: String? {
        (try? data(
            from: NSRange(location: 0, length: length),
            documentAttributes: [
                .documentType: NSAttributedString.DocumentType.html
            ]
        )).flatMap { String(data: $0, encoding: .utf8) }
    }
}

#Preview {
    ContentView()
}

## 🪲 Issue 🪲
This repository contains a `NSTextView` bug that I managed to nail down.  
For some reason, `NSTextView` rendering is lagging when using `NSTextView` with TextKit 1.

#### 📸 Video
https://github.com/wojciech-kulik/Swift-Crazy-iBugs/assets/3128467/535c0fdb-0fb7-45f5-a43a-91d6adb79d94

The weird thing that if I place the cursor in non-empty line, the issue is not reproducible anymore.
<br/><br/>

#### 📱 Environment
I can reproduce it on macOS 13.4. TextKit 1.

#### 🐾 Steps to reproduce
1. Create scrollable `NSTextView` programatically using TextKit 1.
2. Enter empty line and two lines of text.
3. Make sure that there are no empty lines at the end.
4. Set the cursor in the first empty line
5. Hit and hold enter key. Then hit and hold backspace key.

#### 🤔 Actual result
`NSTextView` is lagging with rendering the last line. Also, the last line is duplicated when holding backspace.

#### 🙏🏻 Expected result
`NSTextView` should render text without lagging and artifacts.

#### 🥷🏻 Workarounds
Use TextKit 2 by using this initializer: `NSTextView(usingTextLayoutManager: true)` or `NSTextView.scrollableTextView()`.  
Remember that accessing any TextKit 1 fields like `NSTextView.layoutManager` will switch the `NSTextView` back to TextKit 1.

## 📧 Next steps
These issue has been reported to Apple: #FB12224488.

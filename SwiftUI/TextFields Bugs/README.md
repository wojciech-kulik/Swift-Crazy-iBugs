This repository contains two quite complex bugs related to the memory management of text fields in SwiftUI that I recently discovered.

## 🪲 Issue 1 🪲
Fortunately, I was only able to reproduce it on simulators. However, maybe there is also a way to reproduce it on a physical device.

#### 📱 Environment
This issue is reproducible only on simulators. Confirmed on iOS 14.5 and 16.4.

#### 🐾 Steps to reproduce
It took me a while to figure out what's going on but here are the steps:
1. Create a `View` with two `TextField`s in a `VStack`.
2. Navigate to that `View`.
3. Tap the first `TextField` (it might not be necessary).
4. Go back to the previous screen.

#### 🤔 Actual result
Even if you leave the screen, `TextField`s will be still in memory. What's even worse, if you have a binding in your `View` with `TextField`s, the reference will be kept as well. Therefore, if you bind to a view model, it won't be released.

#### 🙏🏻 Expected result
`TextField`s should be released as soon as you leave the screen including bindings to a view model.

#### 🥷🏻 Workarounds
1. Run it on a physical device.
2. Use just one `TextField` per screen ¯\_(ツ)_/¯.

#### 📸 Screenshot after leaving the screen
<img src="https://github.com/wojciech-kulik/Swift-Crazy-iBugs/assets/3128467/d1acac2a-96f7-4ef6-8709-cd25fb7411f8" width="350" />

<br/><br/>

## 🪲 Issue 2 🪲

This problem is a little bit more tricky to reproduce, but if you have to deal with iOS 14 and custom focus management, it is quite likely that you will encounter this problem sooner or later.

#### 📱 Environment
This issue is reproducible on simulators and physical devices. Confirmed on iPhone 12 Pro with iOS 16.5 and on simulators with iOS 14.5, 15.5, and 16.4.  

#### 🐾 Steps to reproduce
1. Use a custom text field implemented using `UIViewRepresentable`.
2. Make sure to set a keyboard type to `numberPad`.
3. Show your `TextField` with animation.
4. Call ONCE `uiView.becomeFirstResponder()` from `UIViewRepresentable` before the `TextField` is visible.   

As you can see, this is indeed a series of unfortunate events, but it makes this issue even more dangerous. Potentially unrelated changes may trigger this problem.

#### 🤔 Actual result
Even if you leave the screen, `TextField` will be still in the memory. If you have a binding in the `View` with `TextField` the reference will be kept as well. Therefore, if you bind to a view model, it won't be released.  

If you check the memory graph, you will see that the reference to the `TextField` is kept by `UIKBAutofillController`.

#### 🙏🏻 Expected result
`TextField`s should be released as soon as you leave the screen including bindings to a view model.

#### 🥷🏻 Workarounds
There are multiple ways not to fall into this specific bug:
1. Change the keyboard type to a different one, for example: `.default`.
2. Avoid starting the screen with hidden `TextField`.
3. Avoid custom focus implementations.
4. Don't call `becomeFirstResponder()` when the screen appears.
5. Disable Autofill feature in Settings -> Passwords -> Password Options -> AutoFill Passwords.
6. After leaving the screen, tap on a different text field. The keyboard will release the reference to the previous one.

#### 📸 Screenshot after leaving the screen
<img src="https://github.com/wojciech-kulik/Swift-Crazy-iBugs/assets/3128467/725c1565-6bee-4a16-9000-3d7bdc4f4183" width="800" />


<br/><br/>

## 📧 Next steps

These issues have been reported to Apple: #FB12224488. 🤔 This ID seems to be very "random".  
Anyway, probably no one from Apple will ever read this bug, that's why I decided to describe it here.

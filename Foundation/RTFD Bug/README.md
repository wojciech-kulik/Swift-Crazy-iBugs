This bug shows an inconsistency in RTFD serialization.

Bug report: #FB12302537

#### 📱 Environment
Xcode Version 14.3.1 (14E300c)
macOS 13.4 (22F66)

#### 🐾 Steps to reproduce
1. Serialize the RTFD document with images to `Data` using `NSAttributedString.rtfd(from:)` and write it to a file.
2. Read data from that file.
3. Create a new `NSAttributedString` using `.init(rtfd:)`. Use `Data` from #2.
4. Serialize it again using `NSAttributedString.rtfd(from:)`.
5. Compare the initial `Data` and the new `Data`.

#### 🤔 Actual result
There is a few bytes difference between those two. 
It happens only if you include some images in the RTFD.

![file](https://github.com/wojciech-kulik/Swift-RTFD-Bug/assets/3128467/ac981e21-6f0b-4888-92d2-c92cd06da28f)

It looks like the current time is stored for image attachements. Probably a creation/modification date?
Every time I run this code the byte that differs is increased like a timer.

#### 🙏🏻 Expected result
For the same input, we should always get the same output.

#### 👨‍💻 Sample Code

```swift
let path = URL(filePath: FileManager.default.currentDirectoryPath).appendingPathComponent("sample.data")

let oldRtfdData = try! Data(contentsOf: path)
let attr = NSAttributedString(rtfd: oldRtfdData, documentAttributes: nil)!
let newRtfdData = attr.rtfd(from: .init(location: 0, length: attr.length))!

// Even if you overwrite data, the next time it will be again different.
// try! newRtfdData.write(to: path)

let diff = zip(oldRtfdData, newRtfdData)
    .filter {
        if $0 != $1 { print("\($0) != \($1)") }
        return $0 != $1
    }
    .count

print(diff)
print(oldRtfdData == newRtfdData)
```

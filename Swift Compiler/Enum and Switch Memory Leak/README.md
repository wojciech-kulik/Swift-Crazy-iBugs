Memory leaks when using enums with associated values and switch-case.

Bug report: https://github.com/apple/swift/issues/55885  
This issue has been fixed 🎊🎊🎊!

#### 📱 Environment
```
> swift --version
 Apple Swift version 5.2.4 (swiftlang-1103.0.32.9 clang-1103.0.32.53)
 Target: x86_64-apple-darwin19.4.0
```

#### 🐾 Steps to reproduce
```swift
import Foundation

protocol MyProtocol: AnyObject {}

struct Associated1 { // <-- REPLACE STRUCT WITH CLASS TO FIX
    weak var delegate: MyProtocol? // <-- ...OR REMOVE WEAK TO FIX ISSUE
}

final class Associated2 {}

enum MemoryLeakEnum {
    case firstCase(Associated1)
    case secondCase(Associated2)
}

let item: MemoryLeakEnum = .secondCase(Associated2())

func debug(block: () -> ()) {
    block()

    // WHEN LEAKING, EACH SWITCH-CASE INCREASES REF COUNT
    // OF ASSOCIATED VALUE
    if case .secondCase(let value) = item {
        print("Ref Count: \(CFGetRetainCount(value))")
        print("-------------------")
    }
}

func leaking() {
    debug {
        switch item as MemoryLeakEnum? { // IT ONLY HAPPENS IF WE CALL SWITCH WITH OPTIONAL VALUE
        case .firstCase: ()
        default: ()
        }
    }
}

func notLeaking() {
    debug {
        switch item as MemoryLeakEnum? {
        case .secondCase: () // <-- ADDING CASE FOR LEAKING ASSOCIATED VALUE FIXES THE PROBLEM o_O
        default: ()
        }
    }
}

print("##### LEAKING CASE ######\n")
(0..<5).forEach { _ in leaking() }

print("\n##### NOT LEAKING CASE ######\n")
(0..<5).forEach { _ in notLeaking() }
```

#### Workaround
There are several things which can be done to work around this issue:
- Replace struct Associated1 with class Associated1
- Remove weak from Associated1
- Replace the optional value in switch with non-optional
- Use if-case instead of switch
- List all cases in switch


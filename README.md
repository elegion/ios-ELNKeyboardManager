# ELNKeyboardManager

Обертка над стандартным API по обарботке показа и скрытия клавиатуры.

## Installation

###Cocoapods

```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/elegion/ios-podspecs'

pod 'ELNKeyboardManager' 
```

###Carthage

```
github 'elegion/ios-ELNKeyboardManager'
```

## Usage 

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    keyboardManager = ELNKeyboardManager(delegate: self)
}

override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    keyboardManager.enabled = true
}

override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    keyboardManager.enabled = false
}

//MARK: ELNKeyboardManagerDelegate

func keyboardManager(_ keyboardManager: ELNKeyboardManager!, willChangeKeyboardFrameWithFrameBegin frameBegin: CGRect, frameEnd: CGRect) {
    let dY = frameBegin.origin.y - frameEnd.origin.y
    bottomConstraint.constant += dY
    self.view.layoutIfNeeded()
}

```

## Contribution

###Cocoapods

```sh
# download source code, fix bugs, implement new features

pod repo add legion https://github.com/elegion/ios-podspecs
pod repo push legion ELNKeyboardManager.podspec
```

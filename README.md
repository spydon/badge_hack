# badge_hack

Welcome to the Flutter & Friends 2024 badge hack!

Use your imagination to hack around with the provided NFC tags,
creating novel apps and games or expanding on existing ones.

Write to them, read from them, learn from them, and more.
The sky is the limit to what you'll be able to create with
your new friends from Flutter & Friends!

If you need extra NFC tags for your application, let us know!

**Find some inspiration:**

[![Find some inspiration](https://i.ytimg.com/vi/3cqamQYBiSA/sddefault.jpg)](https://www.youtube.com/watch?v=3cqamQYBiSA)

## Setup

Feel free to clone, copy, or download this repo for a basic setup
with some of the permissions already set up.

### Packages

Choose one of the following packages, or others if you know of one.
This template is set up with `package:nfc_manager`.

- `package:nfc_manager`
  - [Package](https://pub.dev/packages/nfc_manager)
  - [API documentation](https://pub.dev/documentation/nfc_manager)
  - [Example](https://github.com/okadan/flutter-nfc-manager/blob/master/example/lib/main.dart)
- `package:flutter_nfc_kit`
  - [Package](https://pub.dev/packages/flutter_nfc_kit)
  - [API documentation](https://pub.dev/documentation/flutter_nfc_kit)
  - [Example](https://github.com/nfcim/flutter_nfc_kit/blob/master/example/lib/main.dart)

### Permissions

NFC reading and writing requires permission setup depending on the platform.

#### Android

Add `android.permission.NFC` to the `app/src/main/AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.NFC"/>
```

#### iOS

iOS 13 or later is required as well as the following setup.

> [!IMPORTANT]  
> To use NFC on a physical iOS device, a paid developer account is required.

- Add the `com.apple.developer.nfc.readersession.formats` entitlement
  to your entitlements (`/ios/Runner/Runner.entitlements`, `/ios/Runner/RunnerDebug.entitlements`):

  ```xml
  <key>com.apple.developer.nfc.readersession.formats</key>
  <array>
      <string>TAG</string>
  </array>
  ```
  
  Note that this entitlement was already added to this template.

- Add a `NFCReaderUsageDescription` to
  your `Info.plist` file (`/ios/Runner/Info.plist`):

  ```xml
  <key>NFCReaderUsageDescription</key>
  <string>Read from NFC Tags</string>
  ```

  Note that this description was already added to this template.

- **Important:** Add the "Near Field Communication Tag Reading" capability in XCode.

  1. Open your `Runner.xcodeproj` in Xcode and click on: `Signing & Capabilities`.
  2. Click on/use the `+ Capability` button.
  3. Add the "Near Field Communication Tag Reading" capability.
  4. Make sure you're using a paid developer account as
     iOS requires it for using NFC.

  <img width="500" alt="A screenshot of the NFC capability" src="https://github.com/user-attachments/assets/708f9e2e-7210-4712-8575-270d70172bed">

## Submission

Your app can be as big or small as you like.
Let us know when you're happy with your creation!

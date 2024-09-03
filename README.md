# badge_hack

Welcome to the Flutter & Friends 2024 badge hack!

Use your imagination to hack around with the provided NFC tags,
creating novel apps and games or expanding on existing ones.

Write to them, read from them, learn from them, and more.
The sky is the limits to what you'll be able to create with
your new friends from Flutter & Friends!

**Find some inspiration:**

[![Find some inspiration](https://i.ytimg.com/vi/3cqamQYBiSA/sddefault.jpg)](https://www.youtube.com/watch?v=3cqamQYBiSA)

## Setup

### Packages

Choose one of the following packages, or others if you know of one.
This template is set up with `package:nfc_manager`.

- `package:nfc_manager`
  - [Package](https://pub.dev/package/nfc_manager)
  - [API documentation](https://pub.dev/documentation/nfc_manager)
  - [Example](https://github.com/okadan/flutter-nfc-manager/blob/master/example/lib/main.dart)
- `package:flutter_nfc_kit`
  - [Package](https://pub.dev/package/flutter_nfc_kit)
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

iOS 13 or later is required as are the following permissions:

- Add the `com.apple.developer.nfc.readersession.formats` entitlement
  to your entitlements (`/ios/Runner/Runner.entitlements`):

  ```xml
  <key>com.apple.developer.nfc.readersession.formats</key>
  <array>
      <string>TAG</string>
  </array>
  ```

- Add a `NFCReaderUsageDescription` to
  your `Info.plist` file (`/ios/Runner/Info.plist`):

  ```xml
  <key>NFCReaderUsageDescription</key>
  <string>Read from NFC Tags</string>
  ```

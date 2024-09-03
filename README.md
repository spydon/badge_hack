# badge_hack

Welcome to the Flutter & Friends 2024 badge hack!

**Find some inspiration:**

[![Find some inspiration](https://img.youtube.com/vi/3cqamQYBiSA/default.jpg)](https://www.youtube.com/watch?v=3cqamQYBiSA)

## Setup

### Android

Add `android.permission.NFC` to the `app/src/main/AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.NFC"/>
```

### iOS

- Add the `com.apple.developer.nfc.readersession.formats` entitlement
  to your entitlements (`/ios/Runner/Runner.entitlements`):

  ```xml
  <key>com.apple.developer.nfc.readersession.formats</key>
      <array>
          <string>TAG</string>
      </array>
  </dict>
  ```

- Add a `NFCReaderUsageDescription` to
  your `Info.plist` file (`/ios/Runner/Info.plist`):

  ```
  <key>NFCReaderUsageDescription</key>
  <string>Read from NFC Tags</string>
  ```

## Packages

Choose one of the following packages, or others if you know of one.
This template is set up with `package:nfc_manager`.

- `package:nfc_manager` [Package](https://pub.dev/package/nfc_manager), [API documentation](https://pub.dev/documentation/nfc_manager)
- `package:flutter_nfc_kit` [Package](https://pub.dev/package/flutter_nfc_kit), [API documentation](https://pub.dev/documentation/flutter_nfc_kit)

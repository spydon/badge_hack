// Template based on example from package:nfc_manager.
// You can find the original example at https://github.com/okadan/flutter-nfc-manager/blob/master/example/lib/main.dart.
// Which is licensed under MIT license found at https://github.com/okadan/flutter-nfc-manager/blob/master/LICENSE.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BadgeHackApp());
}

class BadgeHackApp extends StatefulWidget {
  const BadgeHackApp({super.key});

  @override
  State<StatefulWidget> createState() => BadgeHackAppState();
}

class BadgeHackAppState extends State<BadgeHackApp> {
  ValueNotifier<Object?> result = ValueNotifier<Object?>(null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter & Friends Badge Hack')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: FutureBuilder<bool>(
              future: NfcManager.instance.isAvailable(),
              builder: (context, availableSnapshot) {
                if (availableSnapshot.data != true) {
                  return const Text(
                    'NFC is unavailable or inaccessible. \n'
                    'Verify you followed the setup instructions in the README.',
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: result,
                      builder: (context, Object? value, _) => Text(
                        value?.toString() ?? '',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _tagRead,
                      child: const Text('Read tag'),
                    ),
                    ElevatedButton(
                      onPressed: _ndefWrite,
                      child: const Text('Write to tag'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  void _ndefWrite() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value?.toString());
        return;
      }

      final message = NdefMessage([
        NdefRecord.createText('Hello World!'),
        NdefRecord.createUri(Uri.https('flutter.dev')),
        NdefRecord.createMime(
          'text/plain',
          Uint8List.fromList('Hello'.codeUnits),
        ),
        NdefRecord.createExternal(
          'com.example',
          'mytype',
          Uint8List.fromList('mydata'.codeUnits),
        ),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Successfully wrote the NDEF message.';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }
}

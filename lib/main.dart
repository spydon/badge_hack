// Template based on example from package:nfc_manager.
// You can find the original example at https://github.com/okadan/flutter-nfc-manager/blob/master/example/lib/main.dart.
// Which is licensed under MIT license found at https://github.com/okadan/flutter-nfc-manager/blob/master/LICENSE.

import 'dart:convert';

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
  final textFieldController = TextEditingController();

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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: textFieldController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter URI',
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (textFieldController.text.isNotEmpty) {
                                        _ndefWrite(textFieldController.text);
                                      }
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
      final ndef = Ndef.from(tag);
      if (ndef != null) {
        final data = await ndef.read();
        result.value = data.records.map((r) {
          if (r.typeNameFormat == NdefTypeNameFormat.nfcWellknown) {
            return utf8.decode(r.payload);
          }
          return 'Unhandled record type: ${r.typeNameFormat}';
        }).join(', ');
      }
      NfcManager.instance.stopSession();
    });
  }

  void _ndefWrite(String uri) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value?.toString());
        return;
      }

      final message = NdefMessage([
        NdefRecord.createUri(Uri.https(uri)),
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

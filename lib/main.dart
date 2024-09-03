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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter & Friends Badge Hack')),
        body: SafeArea(
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, availableSnapshot) => Center(
              child: Text('NFC manager availability: '
                  '${availableSnapshot.data}'),
            ),
          ),
        ),
      ),
    );
  }
}

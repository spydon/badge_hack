import 'package:badge_hack/states/game_state.dart';
import 'package:badge_hack/states/scan_nfc_state.dart';
import 'package:flutter/material.dart';

class GameStateManager extends StatefulWidget {
  const GameStateManager({super.key});

  @override
  State<StatefulWidget> createState() => GameStateManagerState();
}

class GameStateManagerState extends State<GameStateManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const ScanNfcState(),
        '/game': (context) => const GameState(),
      },
    );
  }
}

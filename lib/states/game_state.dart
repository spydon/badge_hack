import 'package:badge_hack/constants.dart';
import 'package:badge_hack/flame_game/main_game.dart';
import 'package:badge_hack/flame_game/main_world.dart';
import 'package:badge_hack/widgets/background.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class GameState extends StatefulWidget {
  const GameState({super.key});

  @override
  State<GameState> createState() => _GameStateState();
}

class _GameStateState extends State<GameState> {
  static final MainGame _game = MainGame(world: MainWorld(), camera: CameraComponent());

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, NfcTag>?;
    final nfcTag = args?[Constants.nfcArgumentKey];

    return Scaffold(
      body: SafeArea(
          child: PopScope(
              canPop: false, // Or do we want this to be poppable?
              child: GameWidget(
                game: _game,
                backgroundBuilder: (context) => const Background(),
                overlayBuilderMap: {
                  Constants.gameOverOverlayKey: (context, game) {
                    return Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Game Over',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'You have a score of ${((game as MainGame).world as MainWorld).score}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                ((game as MainGame).world as MainWorld).reset();
                              },
                              child: const Text('Restart'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Exit'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                },
              ))),
    );
  }
}

import 'package:badge_hack/constants.dart';
import 'package:badge_hack/flame_game/components/blob.dart';
import 'package:badge_hack/flame_game/components/spike.dart';
import 'package:badge_hack/flame_game/main_game.dart';
import 'package:badge_hack/global_vars.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class MainWorld extends World with HasGameReference<MainGame>, HasCollisionDetection {
  late final TextComponent _scoreText = TextComponent(text: 'Score: 0')
    ..anchor = Anchor.center
    ..position = Vector2(game.size.x / 2, 20);

  late Blob blob = Blob()
    ..anchor = Anchor.center
    ..position = _initialPlayerPosition;

  late final Vector2 _initialPlayerPosition = Vector2(game.size.x / 2, 5);

  double _timeAlive = 0;
  int get score => _timeAlive.floor();

  @override
  Future<void> onLoad() async {
    game.camera.viewport.add(_scoreText);

    add(blob);
    game.camera.follow(blob, verticalOnly: true);
    game.camera.setBounds(
      Rectangle.fromLTRB(0, 0, game.size.x, game.size.y * 100),
    );

    _clearAndGenerateSpikes();
  }

  void _clearAndGenerateSpikes() {
    for (final spike in children.whereType<Spike>()) {
      spike.removeFromParent();
    }

    for (var i = 0; i < 50; i++) {
      final spike = Spike()
        ..anchor = Anchor.center
        ..position = Vector2(i * 20.0, GlobalVars.random.nextDouble() * game.size.y * 10);

      add(spike);
    }
  }

  @override
  void update(double dt) {
    if (blob.isAlive) {
      _timeAlive += dt;
      _scoreText.text = 'Score: $score';
    }

    super.update(dt);
  }

  void reset() {
    _timeAlive = 0;
    blob.reset();
    blob.position = _initialPlayerPosition;

    game.overlays.remove(Constants.gameOverOverlayKey);

    // We need to re-generate the Random object with the same key to ensure we have
    // a deterministic sequence of random numbers when re-generating the spikes on the same level.
    GlobalVars.regenerateRandomFromSameSeed();
    _clearAndGenerateSpikes();
  }
}

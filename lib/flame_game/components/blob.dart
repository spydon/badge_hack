import 'dart:async';

import 'package:badge_hack/constants.dart';
import 'package:badge_hack/flame_game/components/spike.dart';
import 'package:badge_hack/flame_game/main_game.dart';
import 'package:badge_hack/flame_game/managers/sprite_manager.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Blob extends SpriteComponent with CollisionCallbacks, HasGameReference<MainGame> {
  late int _timeSinceLastGyroEvent = DateTime.now().microsecondsSinceEpoch;

  bool _isAlive = true;
  bool get isAlive => _isAlive;

  Blob() : super(size: Vector2(24, 24), sprite: SpriteManager.getSprite('blob')) {
    scale = Vector2.all(3.5);
  }

  @override
  FutureOr<void> onLoad() {
    gyroscopeEventStream().listen((event) {
      double delta = (event.timestamp.microsecondsSinceEpoch - _timeSinceLastGyroEvent).toDouble();
      _timeSinceLastGyroEvent = event.timestamp.microsecondsSinceEpoch;
      position += Vector2(event.y, 0) * delta / 10000.0;
    });

    add(RectangleHitbox(size: size));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += Vector2(0, 1) * dt * 100;

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Spike && _isAlive) {
      _isAlive = false;
      game.overlays.add(Constants.gameOverOverlayKey);
    }

    super.onCollision(points, other);
  }

  void reset() {
    _isAlive = true;
  }
}
import 'dart:async';

import 'package:badge_hack/flame_game/managers/sprite_manager.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Spike extends SpriteComponent {
  Spike() : super(size: Vector2(18, 18), sprite: SpriteManager.getSprite('spike')) {
    scale = Vector2.all(3);
  }

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(size: size));
    return super.onLoad();
  }
}

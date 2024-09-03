import 'package:badge_hack/flame_game/managers/sprite_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class MainGame extends FlameGame {
  MainGame({required World world, required CameraComponent camera})
      : super(world: world, camera: camera);

  @override
  Future<void> onLoad() async {
    await SpriteManager.init();

    return super.onLoad();
  }

  @override
  void onRemove() {
    removeAll(children);
    processLifecycleEvents();
    Flame.images.clearCache();
    Flame.assets.clearCache();
  }
}

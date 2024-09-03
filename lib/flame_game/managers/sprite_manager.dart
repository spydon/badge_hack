import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class SpriteManager {
  static bool _inited = false;
  static const String _defaultExt = '.png';

  static Future init() async {
    if (_inited) {
      return;
    }

    _inited = true;
    await Flame.images.loadAllImages();
  }

  static Sprite getSprite(String name) => Sprite(Flame.images.fromCache(_fixName(name)));

  static String _fixName(String name) {
    return name.contains('.') ? name : name + _defaultExt;
  }
}

import 'package:badge_hack/constants.dart';
import 'package:nfc_manager/nfc_manager.dart';

class OverlayHelper {
  static int getHighscore(NfcTag? tag) {
    if (tag == null || !tag.data.containsKey(Constants.highscoreKey)) {
      return 0;
    }

    final highscore = int.tryParse(tag.data[Constants.highscoreKey] as String);
    if (highscore == null) {
      return 0;
    }

    return highscore;
  }
}

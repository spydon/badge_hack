import 'dart:math';

class GlobalVars {
  static Random random = Random();
  static int _currentSeed = 0;

  static void regenerateRandomFromNfcHash(String nfcHash) {
    _currentSeed = _stringToSeed(nfcHash);
    random = Random(_stringToSeed(nfcHash));
  }

  static void regenerateRandomFromSameSeed() {
    random = Random(_currentSeed);
  }

  static int _stringToSeed(String input) {
    return input.codeUnits.fold(0, (sum, code) => sum + code);
  }
}

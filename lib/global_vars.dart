import 'dart:math';

class GlobalVars {
  static Random random = Random();

  static void regenerateRandomFromNfcHash(String nfcHash) {
    random = Random(_stringToSeed(nfcHash));
  }

  static int _stringToSeed(String input) {
    return input.codeUnits.fold(0, (sum, code) => sum + code);
  }
}

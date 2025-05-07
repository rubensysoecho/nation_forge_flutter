import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4322967578368905/1076786679';
    } else if (Platform.isIOS || Platform.isMacOS) {
      return 'ca-app-pub-4322967578368905/7586827461';
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4322967578368905/6448532859';
    } else if (Platform.isIOS || Platform.isMacOS) {
      return 'ca-app-pub-4322967578368905/7586827461';
    }
    throw UnsupportedError('Unsupported platform');
  }
}
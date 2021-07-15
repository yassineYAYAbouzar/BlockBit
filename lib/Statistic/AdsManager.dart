import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';

class AdsManager {
  static bool _testMode = false;

  ///
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8576484469053202~2568797054";
    } else if (Platform.isIOS) {
      return "--------------------------------------";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (_testMode == true) {
      return AdmobBanner.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8576484469053202/4486822882";
    } else if (Platform.isIOS) {
      return "--------------------------------------";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (_testMode == true) {
      return AdmobInterstitial.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "--------------------------------------";
    } else if (Platform.isIOS) {
      return "--------------------------------------";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (_testMode == true) {
      return "ca-app-pub-3940256099942544/2247696110";
    } else if (Platform.isAndroid) {
      return "--------------------------------------";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}

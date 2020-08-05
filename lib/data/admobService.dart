import 'dart:io' show Platform;

String getAppId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7807560067485902~2418507212';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-7807560067485902~2683442547';
  }
  return null;
}

String getBannerAdUnitId() {
  if (Platform.isAndroid) {
    return 'ca-app-pub-7807560067485902/1378871210';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-7807560067485902/7096118822';
  }
  return null;
}
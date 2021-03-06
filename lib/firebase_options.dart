// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAjglMpizwrPeYYwtDMWVvS_FY0IKsYfvs',
    appId: '1:277768614632:web:fc6182661076a9edcf8f5d',
    messagingSenderId: '277768614632',
    projectId: 'mlkit-bhushan',
    authDomain: 'mlkit-bhushan.firebaseapp.com',
    storageBucket: 'mlkit-bhushan.appspot.com',
    measurementId: 'G-KKB691G5QG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUAKhYfbqVALJF9dEg1hwWh1qVARMPfBc',
    appId: '1:277768614632:android:68aa4d87f00a96c6cf8f5d',
    messagingSenderId: '277768614632',
    projectId: 'mlkit-bhushan',
    storageBucket: 'mlkit-bhushan.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzRn12FZhc0Y2UYqpPsp6Ukqtx3xBBdo0',
    appId: '1:277768614632:ios:861f7949eb1018f1cf8f5d',
    messagingSenderId: '277768614632',
    projectId: 'mlkit-bhushan',
    storageBucket: 'mlkit-bhushan.appspot.com',
    iosClientId: '277768614632-r2lb2v15bplh4b6iq32l9i802qn7tvt5.apps.googleusercontent.com',
    iosBundleId: 'com.example.newFlutterSdk',
  );
}

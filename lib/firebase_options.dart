// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB5hZyGtpeV3M3rMV14p46YUGFig11wakI',
    appId: '1:963122182720:web:9f307a4083c542e0233da5',
    messagingSenderId: '963122182720',
    projectId: 'scheduler-f5f8b',
    authDomain: 'scheduler-f5f8b.firebaseapp.com',
    storageBucket: 'scheduler-f5f8b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4UwY_Y_RltKndWHM2qxZMDv49BthBnAU',
    appId: '1:963122182720:android:2083e69f323c0266233da5',
    messagingSenderId: '963122182720',
    projectId: 'scheduler-f5f8b',
    storageBucket: 'scheduler-f5f8b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBi4ltGmkcIsezNRvPee90Ym68wd_hS4w4',
    appId: '1:963122182720:ios:fa2a34175e2d8614233da5',
    messagingSenderId: '963122182720',
    projectId: 'scheduler-f5f8b',
    storageBucket: 'scheduler-f5f8b.appspot.com',
    iosBundleId: 'com.example.scheduler',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBi4ltGmkcIsezNRvPee90Ym68wd_hS4w4',
    appId: '1:963122182720:ios:be8e0f50a959a6ee233da5',
    messagingSenderId: '963122182720',
    projectId: 'scheduler-f5f8b',
    storageBucket: 'scheduler-f5f8b.appspot.com',
    iosBundleId: 'com.example.scheduler.RunnerTests',
  );
}

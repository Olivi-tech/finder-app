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
    apiKey: 'AIzaSyAPdTCUMNJQjOQReDmZ8nufcWlwDDvwH0U',
    appId: '1:951250663677:web:973387cda16d8b64196694',
    messagingSenderId: '951250663677',
    projectId: 'finder-13fb7',
    authDomain: 'finder-13fb7.firebaseapp.com',
    storageBucket: 'finder-13fb7.appspot.com',
    measurementId: 'G-27EHQ3QVF8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAT8ucHoTEkiLgZsewTgJ-Vv4657fPrqww',
    appId: '1:951250663677:android:5c167e523dd1c92e196694',
    messagingSenderId: '951250663677',
    projectId: 'finder-13fb7',
    storageBucket: 'finder-13fb7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7N5fFipTj2iG-uTa22Pt5GELS0MCYzJs',
    appId: '1:951250663677:ios:891e318aaef33da2196694',
    messagingSenderId: '951250663677',
    projectId: 'finder-13fb7',
    storageBucket: 'finder-13fb7.appspot.com',
    iosBundleId: 'com.finder.finderApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7N5fFipTj2iG-uTa22Pt5GELS0MCYzJs',
    appId: '1:951250663677:ios:1d978abfa6846e1c196694',
    messagingSenderId: '951250663677',
    projectId: 'finder-13fb7',
    storageBucket: 'finder-13fb7.appspot.com',
    iosBundleId: 'com.finder.finderApp.RunnerTests',
  );
}

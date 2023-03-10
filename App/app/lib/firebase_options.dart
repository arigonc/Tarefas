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
    apiKey: 'AIzaSyCzyNgXNoIP57RyJm0prf37P58ardAZOKo',
    appId: '1:971651552631:web:51bf4edec014963d703d72',
    messagingSenderId: '971651552631',
    projectId: 'aplicativo-f8d6e',
    authDomain: 'aplicativo-f8d6e.firebaseapp.com',
    storageBucket: 'aplicativo-f8d6e.appspot.com',
    measurementId: 'G-0C97BPNWV6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA70pdTlL7VeZ8JOFzIqsNAmXfoTH2ebIg',
    appId: '1:971651552631:android:c079157aaa513286703d72',
    messagingSenderId: '971651552631',
    projectId: 'aplicativo-f8d6e',
    storageBucket: 'aplicativo-f8d6e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-_MrmES_leTt7XLse96CvT_SIYHEVmOw',
    appId: '1:971651552631:ios:2cc3f57b7595e0f3703d72',
    messagingSenderId: '971651552631',
    projectId: 'aplicativo-f8d6e',
    storageBucket: 'aplicativo-f8d6e.appspot.com',
    iosClientId: '971651552631-km0tjpqpqmj4c59ecf3c7sjbpddrqjoe.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-_MrmES_leTt7XLse96CvT_SIYHEVmOw',
    appId: '1:971651552631:ios:2cc3f57b7595e0f3703d72',
    messagingSenderId: '971651552631',
    projectId: 'aplicativo-f8d6e',
    storageBucket: 'aplicativo-f8d6e.appspot.com',
    iosClientId: '971651552631-km0tjpqpqmj4c59ecf3c7sjbpddrqjoe.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );
}

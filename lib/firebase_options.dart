// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCRuQAwQkhbOFWGPIXWgp60TB3UuV0jNIo',
    appId: '1:1017249689025:web:9763ff182db00ecfddd340',
    messagingSenderId: '1017249689025',
    projectId: 'lastproject-595d5',
    authDomain: 'lastproject-595d5.firebaseapp.com',
    storageBucket: 'lastproject-595d5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClBdK41xENOTKVbpVepGoE09ackKeaz0E',
    appId: '1:1017249689025:android:092106ef85dd6193ddd340',
    messagingSenderId: '1017249689025',
    projectId: 'lastproject-595d5',
    storageBucket: 'lastproject-595d5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAd5u59aVGtbb3R_eCdH9I1HlNpm-BKglM',
    appId: '1:1017249689025:ios:ea6473a08f0a9e67ddd340',
    messagingSenderId: '1017249689025',
    projectId: 'lastproject-595d5',
    storageBucket: 'lastproject-595d5.appspot.com',
    iosBundleId: 'com.example.taskym',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAd5u59aVGtbb3R_eCdH9I1HlNpm-BKglM',
    appId: '1:1017249689025:ios:ea6473a08f0a9e67ddd340',
    messagingSenderId: '1017249689025',
    projectId: 'lastproject-595d5',
    storageBucket: 'lastproject-595d5.appspot.com',
    iosBundleId: 'com.example.taskym',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCRuQAwQkhbOFWGPIXWgp60TB3UuV0jNIo',
    appId: '1:1017249689025:web:a513f157e7648b55ddd340',
    messagingSenderId: '1017249689025',
    projectId: 'lastproject-595d5',
    authDomain: 'lastproject-595d5.firebaseapp.com',
    storageBucket: 'lastproject-595d5.appspot.com',
  );

}
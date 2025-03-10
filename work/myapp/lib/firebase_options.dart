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
    apiKey: 'AIzaSyBXjCmBDXca2qAkDX7CNXdio-HMRgdl-LQ',
    appId: '1:72146461489:web:02b2833c75e02fd8d68610',
    messagingSenderId: '72146461489',
    projectId: 'cityguide-3db9a',
    authDomain: 'cityguide-3db9a.firebaseapp.com',
    storageBucket: 'cityguide-3db9a.firebasestorage.app',
    measurementId: 'G-9DJ4GGKGJG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWfPjF0C2MC87P6CBPuth5FLicflASwzA',
    appId: '1:72146461489:android:ea8b0bb700c79abbd68610',
    messagingSenderId: '72146461489',
    projectId: 'cityguide-3db9a',
    storageBucket: 'cityguide-3db9a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVS66H9obPxNZ3Q-p51UfnePrX2gBFS4Y',
    appId: '1:72146461489:ios:c7b3155ac87b9cf9d68610',
    messagingSenderId: '72146461489',
    projectId: 'cityguide-3db9a',
    storageBucket: 'cityguide-3db9a.firebasestorage.app',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVS66H9obPxNZ3Q-p51UfnePrX2gBFS4Y',
    appId: '1:72146461489:ios:c7b3155ac87b9cf9d68610',
    messagingSenderId: '72146461489',
    projectId: 'cityguide-3db9a',
    storageBucket: 'cityguide-3db9a.firebasestorage.app',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXjCmBDXca2qAkDX7CNXdio-HMRgdl-LQ',
    appId: '1:72146461489:web:cdfdf61521c091f9d68610',
    messagingSenderId: '72146461489',
    projectId: 'cityguide-3db9a',
    authDomain: 'cityguide-3db9a.firebaseapp.com',
    storageBucket: 'cityguide-3db9a.firebasestorage.app',
    measurementId: 'G-08LWSM8FRR',
  );
}

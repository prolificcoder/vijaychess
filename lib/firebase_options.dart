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
    apiKey: 'AIzaSyBOZhzvKyc7dXptDwoBLhml3KiD7XbLivA',
    appId: '1:453315614474:web:b0e5ba37924dc4f8d90cf3',
    messagingSenderId: '453315614474',
    projectId: 'vijaychess-8b221',
    authDomain: 'vijaychess-8b221.firebaseapp.com',
    databaseURL: 'https://vijaychess-8b221-default-rtdb.firebaseio.com',
    storageBucket: 'vijaychess-8b221.appspot.com',
    measurementId: 'G-K1P7Q9P67N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVjqbwxjvLzPa-zA8LRI5Li3zhOoFJRfM',
    appId: '1:453315614474:android:3d3eaf5d2fd037f3d90cf3',
    messagingSenderId: '453315614474',
    projectId: 'vijaychess-8b221',
    databaseURL: 'https://vijaychess-8b221-default-rtdb.firebaseio.com',
    storageBucket: 'vijaychess-8b221.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxXJ2pSQjMqMhFJ-iKbaoPlYzAa3tU6-g',
    appId: '1:453315614474:ios:232ea2cf53add30fd90cf3',
    messagingSenderId: '453315614474',
    projectId: 'vijaychess-8b221',
    databaseURL: 'https://vijaychess-8b221-default-rtdb.firebaseio.com',
    storageBucket: 'vijaychess-8b221.appspot.com',
    iosClientId: '453315614474-pg3g9a6da74vlh20e2rqjdmi53ej72f0.apps.googleusercontent.com',
    iosBundleId: 'com.malugu.vijaychess',
  );
}

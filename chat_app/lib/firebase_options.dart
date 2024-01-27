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
    // if (kIsWeb) {
    //   return web;
    // }
    switch (defaultTargetPlatform) {
      // case TargetPlatform.android:
      //   return android;
      case TargetPlatform.iOS:
        return ios;
      // case TargetPlatform.macOS:
      //   return macos;
      // case TargetPlatform.windows:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for windows - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      // case TargetPlatform.linux:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for linux - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: 'AIzaSyDbxDxckPkU2xP76abvRSTmjr9SMcXU2zE',
  //   appId: '1:1054475822345:web:809eb5d468975bfb441fd8',
  //   messagingSenderId: '1054475822345',
  //   projectId: 'chatapp-1c500',
  //   authDomain: 'chatapp-1c500.firebaseapp.com',
  //   storageBucket: 'chatapp-1c500.appspot.com',
  // );

  // static const FirebaseOptions android = FirebaseOptions(
  //   apiKey: 'AIzaSyCgEmtN-fxiaWbZU-arQ6oE1_0EbxAaAwk',
  //   appId: '1:1054475822345:android:e1a6699ace8d22e9441fd8',
  //   messagingSenderId: '1054475822345',
  //   projectId: 'chatapp-1c500',
  //   storageBucket: 'chatapp-1c500.appspot.com',
  // );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFlbn9kx31dKIuyEkSsYHcguFde_QJ8yk',
    appId: '1:1054475822345:ios:18315f47daf23b23441fd8',
    messagingSenderId: '1054475822345',
    projectId: 'chatapp-1c500',
    storageBucket: 'chatapp-1c500.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  // static const FirebaseOptions macos = FirebaseOptions(
  //   apiKey: 'AIzaSyCFlbn9kx31dKIuyEkSsYHcguFde_QJ8yk',
  //   appId: '1:1054475822345:ios:23dbf5d78b623cbe441fd8',
  //   messagingSenderId: '1054475822345',
  //   projectId: 'chatapp-1c500',
  //   storageBucket: 'chatapp-1c500.appspot.com',
  //   iosBundleId: 'com.example.chatApp.RunnerTests',
  // );
}
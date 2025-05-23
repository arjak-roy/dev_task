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
    apiKey: 'AIzaSyBcXzR6SBLh1UqCH0AB1wg7Bo79ROKk7kE',
    appId: '1:328708454508:web:2b8dbb7206bf62fbe00049',
    messagingSenderId: '328708454508',
    projectId: 'devtask-d47db',
    authDomain: 'devtask-d47db.firebaseapp.com',
    storageBucket: 'devtask-d47db.firebasestorage.app',
    measurementId: 'G-K6H55JSTJP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjSgbYSWSA98tZw785VmKCqrfOJvXB1ns',
    appId: '1:328708454508:android:878a73f8e706c812e00049',
    messagingSenderId: '328708454508',
    projectId: 'devtask-d47db',
    storageBucket: 'devtask-d47db.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClibDVFwxivURQb2g3d5TOvvBHg78-atc',
    appId: '1:328708454508:ios:2770bca5dc923707e00049',
    messagingSenderId: '328708454508',
    projectId: 'devtask-d47db',
    storageBucket: 'devtask-d47db.firebasestorage.app',
    iosBundleId: 'com.example.devTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClibDVFwxivURQb2g3d5TOvvBHg78-atc',
    appId: '1:328708454508:ios:2770bca5dc923707e00049',
    messagingSenderId: '328708454508',
    projectId: 'devtask-d47db',
    storageBucket: 'devtask-d47db.firebasestorage.app',
    iosBundleId: 'com.example.devTask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBcXzR6SBLh1UqCH0AB1wg7Bo79ROKk7kE',
    appId: '1:328708454508:web:298dcc10e934f3a0e00049',
    messagingSenderId: '328708454508',
    projectId: 'devtask-d47db',
    authDomain: 'devtask-d47db.firebaseapp.com',
    storageBucket: 'devtask-d47db.firebasestorage.app',
    measurementId: 'G-MWK7MPS8C8',
  );
}

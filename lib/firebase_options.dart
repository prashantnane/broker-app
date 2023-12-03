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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA7CriI7LcENYOXd7nvTBg2HDeXn7-AMAw',
    appId: '1:302412946332:web:1b864c75c726bb254cc659',
    messagingSenderId: '302412946332',
    projectId: 'broker-app-17c72',
    authDomain: 'broker-app-17c72.firebaseapp.com',
    databaseURL: 'https://broker-app-17c72-default-rtdb.firebaseio.com',
    storageBucket: 'broker-app-17c72.appspot.com',
    measurementId: 'G-B3KYRFKCW3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMftgaBxtn_v9Y1cgHLGTomJjz8cxXJhY',
    appId: '1:302412946332:android:43f27facbee555bf4cc659',
    messagingSenderId: '302412946332',
    projectId: 'broker-app-17c72',
    databaseURL: 'https://broker-app-17c72-default-rtdb.firebaseio.com',
    storageBucket: 'broker-app-17c72.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDdYlCF6HJEqrLnyo0PmFFBQnIsF6_hwlk',
    appId: '1:302412946332:ios:99e665282bdbc0824cc659',
    messagingSenderId: '302412946332',
    projectId: 'broker-app-17c72',
    databaseURL: 'https://broker-app-17c72-default-rtdb.firebaseio.com',
    storageBucket: 'broker-app-17c72.appspot.com',
    androidClientId: '302412946332-2lhd0cj8c4bn9tep4d73cv9ksr0j6mbs.apps.googleusercontent.com',
    iosClientId: '302412946332-qc9ubb10gvfrl624klm292t0n9ef10a4.apps.googleusercontent.com',
    iosBundleId: 'com.ebroker.wrteam',
  );
}
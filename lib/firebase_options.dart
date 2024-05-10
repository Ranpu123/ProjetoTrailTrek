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
    apiKey: 'AIzaSyD2CmJ438W1oyDDzpvqLNliNrWMJs94Up0',
    appId: '1:139811719879:web:ab50f96fdefe8be43ccce2',
    messagingSenderId: '139811719879',
    projectId: 'projdevdispmob',
    authDomain: 'projdevdispmob.firebaseapp.com',
    databaseURL: 'https://projdevdispmob-default-rtdb.firebaseio.com',
    storageBucket: 'projdevdispmob.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZY8oBm90IiNE4ECMoyAo2R8Z03f0uC7s',
    appId: '1:139811719879:android:55074a5f1003e0103ccce2',
    messagingSenderId: '139811719879',
    projectId: 'projdevdispmob',
    databaseURL: 'https://projdevdispmob-default-rtdb.firebaseio.com',
    storageBucket: 'projdevdispmob.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAybGOWWDIw9FU4nWz6hUvgA1sJi8NdVaQ',
    appId: '1:139811719879:ios:84e7f000a2ebfadc3ccce2',
    messagingSenderId: '139811719879',
    projectId: 'projdevdispmob',
    databaseURL: 'https://projdevdispmob-default-rtdb.firebaseio.com',
    storageBucket: 'projdevdispmob.appspot.com',
    iosBundleId: 'br.com.projetoDDM.projetoDevDispMob',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAybGOWWDIw9FU4nWz6hUvgA1sJi8NdVaQ',
    appId: '1:139811719879:ios:84e7f000a2ebfadc3ccce2',
    messagingSenderId: '139811719879',
    projectId: 'projdevdispmob',
    databaseURL: 'https://projdevdispmob-default-rtdb.firebaseio.com',
    storageBucket: 'projdevdispmob.appspot.com',
    iosBundleId: 'br.com.projetoDDM.projetoDevDispMob',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD2CmJ438W1oyDDzpvqLNliNrWMJs94Up0',
    appId: '1:139811719879:web:61c37df26dcc462d3ccce2',
    messagingSenderId: '139811719879',
    projectId: 'projdevdispmob',
    authDomain: 'projdevdispmob.firebaseapp.com',
    databaseURL: 'https://projdevdispmob-default-rtdb.firebaseio.com',
    storageBucket: 'projdevdispmob.appspot.com',
  );

}
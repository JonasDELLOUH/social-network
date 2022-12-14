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
    apiKey: 'AIzaSyBWOvb-Zdgq7okKE80ugcuIdCrucOEgl98',
    appId: '1:557979572247:web:06a56592953af8d4d26452',
    messagingSenderId: '557979572247',
    projectId: 'fluttersocial-f5587',
    authDomain: 'fluttersocial-f5587.firebaseapp.com',
    storageBucket: 'fluttersocial-f5587.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcKBHWWKDCU9T8fOlVl0hd2iMlNFM1Nu8',
    appId: '1:557979572247:android:383bcee4179d67cbd26452',
    messagingSenderId: '557979572247',
    projectId: 'fluttersocial-f5587',
    storageBucket: 'fluttersocial-f5587.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsdj8DBgT19VtfORF38eG8qHeA0bF0Wok',
    appId: '1:557979572247:ios:d68e5af1c4367547d26452',
    messagingSenderId: '557979572247',
    projectId: 'fluttersocial-f5587',
    storageBucket: 'fluttersocial-f5587.appspot.com',
    iosClientId: '557979572247-kfc09o9sndpr510aojl5fl4mgjv8enk5.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterSocial2',
  );
}

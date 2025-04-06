import 'package:chat_app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
          apiKey: "AIzaSyANRU-GU1gsqTXwnmxF9_APiokUHa1BDpo",
          authDomain: "chat-app-82cb7.firebaseapp.com",
          projectId: "chat-app-82cb7",
          storageBucket: "chat-app-82cb7.firebasestorage.app",
          messagingSenderId: "96080305404",
          appId: "1:96080305404:web:caa47052392eee9215cb79",
          measurementId: "G-CHVFDB0ZRY"),
    );
  } else {
    await Firebase.initializeApp();
  }
}

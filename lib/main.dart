import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/auth/login_page.dart';
import 'package:flutter_application_1/auth/welcome_page.dart';
import 'package:flutter_application_1/firebase_options.dart';

//import 'dart:developer' as devtools show log;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: ,
      // theme: ThemeData(),
      home: const LoginPage(),
      
    );
  }
}

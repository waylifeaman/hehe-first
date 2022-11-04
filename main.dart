import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ujikom_fiks/firebase_options.dart';
import 'package:ujikom_fiks/layout/login.dart';
import 'package:ujikom_fiks/rules/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: cPrimary,
      ),
      home: Login(),
    );
  }
}

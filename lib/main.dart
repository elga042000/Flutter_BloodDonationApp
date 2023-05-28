import 'package:flutter/material.dart';
import 'project2/home.dart';
import 'project2/add.dart';
import 'project2/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood donation app',
      routes: {
        '/': (context) => const HomePage(),
        '/add': (context) => const AddUser(),
        '/update':(context) => const UpdateDonor(),
      },
      initialRoute: '/',
    );
  }
}

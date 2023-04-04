import 'package:booking/screens/auth.dart';
import 'package:booking/screens/home.dart';
import 'package:booking/screens/join_queue.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          actionsIconTheme:
              IconThemeData(color: Theme.of(context).primaryColor),
          centerTitle: true,
        ),
      ),
      home: Authscreen(),
      routes: {
        Authscreen.routeName: (context) => Authscreen(),
        Home.routeName: (context) => const Home(),
        JoinQueueScreen.routeName: (context) => const JoinQueueScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

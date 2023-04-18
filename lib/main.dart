import 'package:booking/screens/admin/admin_home.dart';
import 'package:booking/screens/admin/edit_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/admin/admin_auth.dart';
import 'screens/auth.dart';
import 'screens/home.dart';
import 'screens/join_queue.dart';
import 'utils/queues.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Queues(),
      child: MaterialApp(
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
        home: FirebaseAuth.instance.currentUser == null
            ? Authscreen()
            : const Home(),
        routes: {
          Authscreen.routeName: (context) => Authscreen(),
          AdminAuth.routeName:(context) => AdminAuth(),
          Home.routeName: (context) => const Home(),
          AdminHomePage.routeName:(context) => const AdminHomePage(),
          JoinQueueScreen.routeName: (context) => const JoinQueueScreen(),
          EditServices.routeName:(context) => const EditServices(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

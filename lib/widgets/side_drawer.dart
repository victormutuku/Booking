import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/auth.dart';
import '../screens/home.dart';
import '../screens/join_queue.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              alignment: Alignment.bottomLeft,
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              color: Colors.blue,
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pushNamed(Home.routeName),
            ),
            ListTile(
              leading: const Icon(Icons.list, color: Colors.black),
              title: const Text('Join Queue'),
              onTap: () =>
                  Navigator.of(context).pushNamed(JoinQueueScreen.routeName),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushReplacementNamed(Authscreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}

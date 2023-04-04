import 'package:booking/screens/auth.dart';
import 'package:booking/screens/join_queue.dart';
import 'package:flutter/material.dart';

enum MenuOptions { logout }

class Home extends StatelessWidget {
  static const routeName = "/homescreen";

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Queue',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          PopupMenuButton(
            position: PopupMenuPosition.under,
            onSelected: (value) {
              if (value == MenuOptions.logout) {
                Navigator.of(context)
                    .pushReplacementNamed(Authscreen.routeName);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: MenuOptions.logout,
                child: Text('Logout'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: ListView(
            children: [
              ListTile(
                title: const Text('Brian'),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Chip(
                      label: const Text('Serving'),
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text('30 min'),
                  ],
                ),
              ),
              const Divider(),
              const ListTile(
                title: Text('John'),
                trailing: Text('40 min'),
              ),
              const Divider(),
              const ListTile(
                title: Text('Jane'),
                trailing: Text('30 min'),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(JoinQueueScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

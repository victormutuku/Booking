import 'package:booking/screens/auth.dart';
import 'package:booking/screens/join_queue.dart';
import 'package:booking/utils/queues.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MenuOptions { logout }

class Home extends StatefulWidget {
  static const routeName = "/homescreen";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final List items = [];

  @override
  void didChangeDependencies() {
    Provider.of<Queues>(context).retrieveUserDetails();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final databaseReference = database.ref().child("/users_services");
    final userServices = Provider.of<Queues>(context).userServices;

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
                FirebaseAuth.instance.signOut();
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
          child: userServices.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Consumer<Queues>(builder: (context, queue, _) {
                  return ListView.separated(
                    itemCount: queue.userServices.length,
                    itemBuilder: (context, index) {
                      List<String> titles = [];
                      List<int> timePeriod = [];
                      for (int i = 0; i < queue.userServices.length; i++) {
                        Map<String, int> val =
                            queue.userServices.values.elementAt(i);
                        titles.addAll(val.keys);
                        timePeriod.addAll(val.values);
                      }
                      return ListTile(
                        title: Text(titles[index]),
                        trailing: Text(
                            '${(timePeriod[index] / 60).floor()} hrs ${timePeriod[index] % 60} mins'),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                }),
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

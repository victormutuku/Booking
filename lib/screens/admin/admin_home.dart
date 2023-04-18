import 'dart:developer';

import 'package:booking/utils/queues.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_services.dart';

class AdminHomePage extends StatefulWidget {
  static const routeName = "/admin";
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  // final FirebaseDatabase database = FirebaseDatabase.instance;
  Map<String, int> serviceValueList = {};

  @override
  void didChangeDependencies() {
    Provider.of<Queues>(context, listen: false).fetchServiceValues();
    serviceValueList = Provider.of<Queues>(context).serviceValueList;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 15,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Services',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Time Taken',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.3,
                child: serviceValueList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Consumer<Queues>(
                        builder: (context, val, _) {
                          List<int> timePeriod = [];
                          timePeriod.addAll(val.serviceValueList.values);
                          log(timePeriod.toString());
                          return ListView.builder(
                            itemCount: val.serviceValueList.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(
                                serviceValueList.keys.elementAt(index),
                              ),
                              trailing: Text(
                                  '${(timePeriod[index] / 60).floor()} hrs ${timePeriod[index] % 60} mins'),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(EditServices.routeName),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                child: const Text('Edit Services'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

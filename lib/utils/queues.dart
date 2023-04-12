import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Queues with ChangeNotifier {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final Map<String, Map<String, int>> userServices = {};
  String authErrorResponse = "";

  void joinQueue(int selectedHrs, int selectedMins, List<String> services) {
    final databaseReference = database.ref().child("/users_services");
    int serviceTimePeriod = selectedHrs * 60 + selectedMins;

    databaseReference.push().set(
      {
        FirebaseAuth.instance.currentUser!.uid: {
          "username": FirebaseAuth.instance.currentUser!.displayName,
          "services": services,
          "travel_time": serviceTimePeriod,
          "service_time": serviceTimePeriod,
          "total_Service_time": serviceTimePeriod,
          "dateCreated": DateTime.now().toIso8601String(),
        },
      },
    );
    notifyListeners();
  }

  retrieveUserDetails() async {
    // Reference to the database
    final userServicesRef = database.ref().child("/users_services");

    //Retrieve data through a DatabaseEvent
    final userServ = await userServicesRef.once();

    //Get the data values from the Database Event and cast as a Map
    final retUserServ = userServ.snapshot.value as Map;

    // Create another map from the previous map.
    //This allows us to add integer keys for easy searching
    int i = 0;
    final fUserServ = {
      for (var element in retUserServ.values) i++: element as Map
    };

    // Extract the needed values from the map
    for (int i = 0; i < fUserServ.length; i++) {
      final el = fUserServ[i]!;
      // log(el.keys.first.toString());
      for (int j = 0; j < el.length; j++) {
        final ml = el.values.toList().toList();
        final vl = ml.first;
        userServices.putIfAbsent(
            vl['dateCreated'], () => {vl['username']: vl['service_time']});
      }
    }
    // log(userServices.toString());
    notifyListeners();
    return userServices;
  }
}

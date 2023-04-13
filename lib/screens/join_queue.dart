import 'package:booking/widgets/side_drawer.dart';

import '../utils/queues.dart';
import '../utils/strings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Service { oilchange, tires, service, paint }

class JoinQueueScreen extends StatefulWidget {
  static const routeName = "/joinqueue";
  const JoinQueueScreen({super.key});

  @override
  State<JoinQueueScreen> createState() => _JoinQueueScreenState();
}

class _JoinQueueScreenState extends State<JoinQueueScreen> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final List<String> services = [];

  bool _oilChangeSelected = false;
  bool _tiresSelected = false;
  bool _serviceSelected = false;
  bool _paintSelected = false;

  int selectedHrs = 0;
  int selectedMins = 0;

  _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: const Text('Successful'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Join Queue',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      drawer: const SideDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  children: const [
                    Text(
                      'Select reason of visit:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Checkbox(
                  side: const BorderSide(width: 1.5),
                  value: _oilChangeSelected,
                  onChanged: (value) {
                    setState(() {
                      _oilChangeSelected = !_oilChangeSelected;
                    });
                    if (_oilChangeSelected == true) {
                      services.add("Oil Change");
                    } else {
                      if (services.contains("Oil Change") == true) {
                        services.remove('Oil Change');
                      }
                    }
                  },
                ),
                title: const Text('Oil Change'),
              ),
              ListTile(
                leading: Checkbox(
                  side: const BorderSide(width: 1.5),
                  value: _tiresSelected,
                  onChanged: (value) {
                    setState(() {
                      _tiresSelected = !_tiresSelected;
                    });
                    if (_tiresSelected == true) {
                      services.add("Tires");
                    } else {
                      if (services.contains("Tires") == true) {
                        services.remove("Tires");
                      }
                    }
                  },
                ),
                title: const Text('Tires'),
              ),
              ListTile(
                leading: Checkbox(
                  side: const BorderSide(width: 1.5),
                  value: _serviceSelected,
                  onChanged: (value) {
                    setState(() {
                      _serviceSelected = !_serviceSelected;
                    });
                    if (_serviceSelected == true) {
                      services.add("Service");
                    } else {
                      if (services.contains("Services") == true) {
                        services.remove("Service");
                      }
                    }
                  },
                ),
                title: const Text('Service'),
              ),
              ListTile(
                leading: Checkbox(
                  side: const BorderSide(width: 1.5),
                  value: _paintSelected,
                  onChanged: (value) {
                    setState(() {
                      _paintSelected = !_paintSelected;
                    });
                    if (_paintSelected == true) {
                      services.add("Paint job");
                    } else {
                      if (services.contains("Paint job") == true) {
                        services.remove("Paint job");
                      }
                    }
                  },
                ),
                title: const Text('Paint'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: const [
                    Text(
                      'Travel Time:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton(
                    key: UniqueKey(),
                    value: selectedHrs == 0 ? null : selectedHrs,
                    borderRadius: BorderRadius.circular(20),
                    menuMaxHeight: 200,
                    onChanged: (value) {
                      setState(() {
                        selectedHrs = value!;
                      });
                    },
                    // value: selectedTimeValue,
                    items: hrsList,
                    hint: const Text("Hrs"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                    key: UniqueKey(),
                    value: selectedMins == 0 ? null : selectedMins,
                    borderRadius: BorderRadius.circular(20),
                    menuMaxHeight: 200,
                    items: minsList,
                    hint: const Text("Min"),
                    onChanged: (value) {
                      setState(() {
                        selectedMins = value!;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('or'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          'Pick by Location',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: const [
                    Text(
                      'Service Time:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: const [
                    Text(
                      '50 min',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 50, bottom: 10),
                child: Row(
                  children: const [
                    Text(
                      'Total Service Time:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: const [
                    Text(
                      '50 min',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 90, right: 8.0),
                child: ListTile(
                  title: const Text(
                    "Join Queue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<Queues>(context, listen: false)
                              .joinQueue(selectedHrs, selectedMins, services);
                          setState(() {
                            _showSnackBar();
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text('Yes'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

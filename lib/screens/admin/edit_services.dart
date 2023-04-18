import 'package:booking/models/service.dart';
import 'package:booking/utils/queues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/strings.dart';

class EditServices extends StatefulWidget {
  static const routeName = "/editservices";
  const EditServices({super.key});

  @override
  State<EditServices> createState() => _EditServicesState();
}

class _EditServicesState extends State<EditServices> {
  List<Service> serviceList = [];
  String errorMessage = "";
  int oilChangeHrs = 0;
  int oilChangeMins = 0;
  int tiresHrs = 0;
  int tiresMins = 0;
  int serviceHrs = 0;
  int serviceMins = 0;
  int paintHrs = 0;
  int paintMins = 0;

  _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: const Text('Successful'),
      ),
    );
  }

  bool _validationCheck() {
    if (oilChangeHrs == 0 && oilChangeMins == 0) {
      setState(() {
        errorMessage = "Oil Change time is empty!";
      });
      return false;
    } else {
      var oilserv = Service(
        name: "Oil Change",
        hrs: oilChangeHrs,
        mins: oilChangeMins,
      );
      if (!serviceList.contains(oilserv)) {
        serviceList.add(oilserv);
      }
    }
    if (tiresHrs == 0 && tiresMins == 0) {
      setState(() {
        errorMessage = "Tires time is empty!";
      });
      return false;
    } else {
      var tireserv = Service(
        name: "Tires",
        hrs: tiresHrs,
        mins: tiresMins,
      );
      if (!serviceList.contains(tireserv)) {
        serviceList.add(tireserv);
      }
    }
    if (serviceHrs == 0 && serviceMins == 0) {
      setState(() {
        errorMessage = "Service time is empty!";
      });
      return false;
    } else {
      var servserv = Service(
        name: "Service",
        hrs: serviceHrs,
        mins: serviceMins,
      );
      if (!serviceList.contains(servserv)) {
        serviceList.add(servserv);
      }
    }
    if (paintHrs == 0 && paintMins == 0) {
      setState(() {
        errorMessage = "Paint time is empty!";
      });
      return false;
    } else {
      var paintserv = Service(
        name: "Paint",
        hrs: paintHrs,
        mins: paintMins,
      );
      if (!serviceList.contains(paintserv)) {
        serviceList.add(paintserv);
      }
    }
    return true;
  }

  _submit() {
    if (_validationCheck() == true) {
      setState(() {
        errorMessage = "";
      });
      Provider.of<Queues>(context, listen: false).postServices(serviceList);
      serviceList.clear();
      _showSnackBar();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Services',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'Services:',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text('Oil Change'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        key: UniqueKey(),
                        value: oilChangeHrs == 0 ? null : oilChangeHrs,
                        borderRadius: BorderRadius.circular(20),
                        menuMaxHeight: 200,
                        onChanged: (value) {
                          setState(() {
                            oilChangeHrs = value!;
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
                        value: oilChangeMins == 0 ? null : oilChangeMins,
                        borderRadius: BorderRadius.circular(20),
                        menuMaxHeight: 200,
                        items: minsList,
                        hint: const Text("Min"),
                        onChanged: (value) {
                          setState(() {
                            oilChangeMins = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Tires'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        key: UniqueKey(),
                        value: tiresHrs == 0 ? null : tiresHrs,
                        borderRadius: BorderRadius.circular(20),
                        menuMaxHeight: 200,
                        onChanged: (value) {
                          setState(() {
                            tiresHrs = value!;
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
                        value: tiresMins == 0 ? null : tiresMins,
                        borderRadius: BorderRadius.circular(20),
                        menuMaxHeight: 200,
                        items: minsList,
                        hint: const Text("Min"),
                        onChanged: (value) {
                          setState(() {
                            tiresMins = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Service'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        key: UniqueKey(),
                        value: serviceHrs == 0 ? null : serviceHrs,
                        borderRadius: BorderRadius.circular(20),
                        menuMaxHeight: 200,
                        onChanged: (value) {
                          setState(() {
                            serviceHrs = value!;
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
                        value: serviceMins == 0 ? null : serviceMins,
                        borderRadius: BorderRadius.circular(20),
                        menuMaxHeight: 200,
                        items: minsList,
                        hint: const Text("Min"),
                        onChanged: (value) {
                          setState(() {
                            serviceMins = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Paint'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        key: UniqueKey(),
                        value: paintHrs == 0 ? null : paintHrs,
                        borderRadius: BorderRadius.circular(20),
                        menuMaxHeight: 200,
                        onChanged: (value) {
                          setState(() {
                            paintHrs = value!;
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
                        value: paintMins == 0 ? null : paintMins,
                        borderRadius: BorderRadius.circular(20),
                        menuMaxHeight: 200,
                        items: minsList,
                        hint: const Text("Min"),
                        onChanged: (value) {
                          setState(() {
                            paintMins = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Save'),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  errorMessage,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

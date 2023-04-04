import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({super.key});

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  bool _oilChangeSelected = false;
  bool _tiresSelected = false;
  bool _serviceSelected = false;
  bool _paintSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Checkbox(
            side: const BorderSide(width: 1.5),
            value: _oilChangeSelected,
            onChanged: (value) {
              setState(() {
                _oilChangeSelected = !_oilChangeSelected;
              });
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
            },
          ),
          title: const Text('Paint'),
        ),
      ],
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_timer/custom_timer.dart';
import '../widgets/side_drawer.dart';
import '../utils/queues.dart';

class Home extends StatefulWidget {
  static const routeName = "/homescreen";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final List items = [];
  late CustomTimerController controller;

  @override
  void initState() {
    controller = CustomTimerController(
        vsync: this,
        begin: const Duration(hours: 5),
        end: const Duration(),
        initialState: CustomTimerState.counting,
        interval: CustomTimerInterval.milliseconds);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Queues>(context).retrieveUserDetails();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userServices = Provider.of<Queues>(context).userServices;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Queue',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      drawer: const SideDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Time Remaining',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTimer(
                        controller: controller,
                        builder: (state, time) => Text(
                          '${time.hours}:${time.minutes}:${time.seconds}',
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ]),
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
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
                            for (int i = 0;
                                i < queue.userServices.length;
                                i++) {
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
            ],
          ),
        ),
      ),
    );
  }
}

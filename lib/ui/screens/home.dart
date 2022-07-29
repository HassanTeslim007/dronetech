import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dronetech/model/drone.dart';
import 'package:flutter/material.dart';

import '../dialogs/add_drone.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<List<Drone>> fetchDrones() => FirebaseFirestore.instance
      .collection('Drone Collection')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((drone) => Drone.fromJson(drone.data())).toList());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drones'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Drone>>(
          stream: fetchDrones(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final drones = snapshot.data!;
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                child: ListView(
                    children: drones.map((drone) => droneTile(drone)).toList()),
              );
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No drone Found'));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                extendedSizeConstraints: BoxConstraints.tightFor(
                    height: height * 0.05, width: width * 0.3))),
        child: FloatingActionButton.extended(
          onPressed: () {
            addDrone(context);
          },
          label: const Text('Add Drone'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

void addDrone(context) {
  showDialog(
      context: context,
      builder: ((context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: const DroneDialog());
      }));
}

Widget droneTile(Drone drone) {
  return ListTile(
    title: Text(drone.id!),
    subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Manufacturer: ${drone.manufacturer!}'),
      Text('Serviced: ${drone.serviced!}'),
      Text('Date Acquired: ${drone.acquisitionDate!}'),
    ]),
  );
}

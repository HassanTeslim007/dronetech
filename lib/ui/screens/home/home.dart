import 'package:dronetech/model/drone.dart';
import 'package:dronetech/ui/screens/home/home_logic.dart';
import 'package:flutter/material.dart';

import '../../widgets/drone_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HomeLogic();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drones'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Drone>>(
          stream: controller.fetchDrones(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final drones = snapshot.data;
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                child: ListView(
                    children: drones!
                        .map((drone) => Dismissible(
                            background: Container(color: Colors.red),
                            key: Key(drone.id!),
                            onDismissed: (direction) {
                              controller.deleteDrone(drone.id!, context);
                            },
                            child: DroneTile(drone: drone)))
                        .toList()),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something is Wrong'));
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
            controller.addDrone(context);
            // controller.deleteDrone('Heli H7');
          },
          label: const Text('Add Drone'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

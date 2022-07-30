import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/drone.dart';
import '../../dialogs/drone_dialog/drone_dialog.dart';

class HomeLogic {
  //Fetch Drones
  Stream<List<Drone>> fetchDrones() => FirebaseFirestore.instance
      .collection('Drones collection')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((drone) => Drone.fromJson(drone.data())).toList());
  //Add New drone
  void addDrone(context) {
    showDialog(
        context: context,
        builder: ((context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: const DroneDialog());
        }));
  }

  // delete Drone Field
  void deleteDrone(String id, context) {
    final drone =
        FirebaseFirestore.instance.collection('Drones collection').doc(id);

   
    try {
     drone.delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Drone Deleted Successfully'),
        backgroundColor: Colors.green[400],
      ));
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Drone could not be deleted'),
        backgroundColor: Colors.redAccent[400],
      ));
    }
  }
}

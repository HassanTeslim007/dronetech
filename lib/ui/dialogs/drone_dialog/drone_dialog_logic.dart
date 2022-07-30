import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/drone.dart';

class DroneDialogLogic {
  TextEditingController idController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool? droneCondition = true;
  String? selectedDate;
  final formKey = GlobalKey<FormState>();

  void dispose() {
    idController.dispose();
    weightController.dispose();
    manufacturerController.dispose();
    dateController.dispose();
  }

  //write to db
  void addDrone(context) {
    var id = idController.text;
    var weight = weightController.text;
    var manufacturer = manufacturerController.text;
    var serviced = droneCondition;
    var acquisitionDate = selectedDate.toString();
    Drone drone = Drone(
        id: id,
        weight: '${weight}kg',
        manufacturer: manufacturer,
        serviced: serviced,
        acquisitionDate: acquisitionDate);
    final droneDB =
        FirebaseFirestore.instance.collection('Drones collection').doc(id);
    //validate form
    if (formKey.currentState!.validate()) {
      try {
        droneDB.set(drone.toJson());
        //show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Drone Added Successfully'),
          backgroundColor: Colors.green[400],
        ));
      } on Exception {
        //show failure snackbar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Drone Added Failed'),
          backgroundColor: Colors.redAccent[400],
        ));
      }
      idController.clear();
      weightController.clear();
      manufacturerController.clear();
      dateController.clear();
      Navigator.pop(context);
    }
  }
}

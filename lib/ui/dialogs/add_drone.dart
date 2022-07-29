import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dronetech/model/drone.dart';
import 'package:flutter/material.dart';

class DroneDialog extends StatefulWidget {
  const DroneDialog({Key? key}) : super(key: key);

  @override
  State<DroneDialog> createState() => _DroneDialogState();
}

class _DroneDialogState extends State<DroneDialog> {
  TextEditingController idController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool? droneCondition = true;
  DateTime? selectedDate;

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    weightController.dispose();
    manufacturerController.dispose();
    dateController.dispose();
  }

  void addDrone() {
    var id = idController.text;
    var weight = weightController.text;
    var manufacturer = manufacturerController.text;
    var serviced = droneCondition;
    var acquisitionDate = selectedDate.toString().substring(0, 10);
    Drone drone = Drone(
        id: id,
        weight: '${weight}kg',
        manufacturer: manufacturer,
        serviced: serviced,
        acquisitionDate: acquisitionDate);
    final droneDB = FirebaseFirestore.instance.collection('Drones collection');

    try {
      droneDB.add(drone.toJson());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Drone Added Successfully'),
        backgroundColor: Colors.green[400],
      ));
    } on Exception {
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

  selectDate() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2010),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    setState(() {
      if (newDate == null) {
        return;
      } else {
        selectedDate = newDate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: SizedBox(
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: idController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'ID tag',
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Weight Capacity in Kg',
                  )),
              SizedBox(
                height: height * 0.02,
              ),
              TextFormField(
                  controller: manufacturerController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Manufacturer',
                  )),
              SizedBox(
                height: height * 0.03,
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2.5,
                      height: height * 0.046,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: width * 0.03, color: Colors.black))),
                        value: 'Serviced',
                        items: ['Serviced', 'Not Serviced']
                            .map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                )))
                            .toList(),
                        onChanged: (val) {
                          if (val == 'Serviced') {
                            droneCondition = true;
                          } else {
                            droneCondition = false;
                          }
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await selectDate();
                      },
                      child: SizedBox(
                        width: width * 0.45,
                        child: TextField(
                            controller: dateController,
                            enabled: false,
                            decoration: InputDecoration(
                                hintText: selectedDate == null
                                    ? 'Date of acquisition'
                                    : '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: width * 0.03,
                                        color: Colors.black)))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              ElevatedButton(
                  onPressed: addDrone, child: const Text('Add Drone'))
            ],
          )),
        ),
      ),
    );
  }
}

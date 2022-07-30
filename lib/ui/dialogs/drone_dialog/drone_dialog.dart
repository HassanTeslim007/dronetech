import 'package:dronetech/ui/dialogs/drone_dialog/drone_dialog_logic.dart';
import 'package:flutter/material.dart';

class DroneDialog extends StatefulWidget {
  const DroneDialog({Key? key}) : super(key: key);

  @override
  State<DroneDialog> createState() => _DroneDialogState();
}

class _DroneDialogState extends State<DroneDialog> {
  final controller = DroneDialogLogic();

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
        controller.dateController.text = newDate.toString().substring(0, 10);
        controller.selectedDate = controller.dateController.text;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) return "Enter Drone ID";
                      return null;
                    },
                    controller: controller.idController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'ID tag',
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) return "Enter Drone Weight Capacity";
                        return null;
                      },
                      controller: controller.weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Weight Capacity in Kg',
                      )),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) return "Enter Manufacturer Name";
                        return null;
                      },
                      controller: controller.manufacturerController,
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
                          //height: height * 0.05,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: width * 0.03,
                                        color: Colors.black))),
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
                                controller.droneCondition = true;
                              } else {
                                controller.droneCondition = false;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.45,
                          child: TextFormField(
                              onTap: () async {
                                await selectDate();
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Select Acquisition Date";
                                }
                                return null;
                              },
                              controller: controller.dateController,
                              showCursor: true,
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: 'Date of acquisition',
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                          width: width * 0.03,
                                          color: Colors.black)))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  ElevatedButton(
                      onPressed: () => controller.addDrone(context),
                      child: const Text('Add Drone'))
                ],
              )),
        ),
      ),
    );
  }
}

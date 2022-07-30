import 'package:flutter/material.dart';

import '../../model/drone.dart';

class DroneTile extends StatelessWidget {
  final Drone drone;
  const DroneTile({Key? key, required this.drone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        drone.id!,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Manufacturer: ${drone.manufacturer!}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Serviced: '),
                    Text(
                      drone.serviced!.toString(),
                      style: TextStyle(
                          color: drone.serviced == false
                              ? Colors.red
                              : Colors.green),
                    ),
                  ],
                ),
                Text('Date Acquired: ${drone.acquisitionDate!}'),
              ],
            ),
          ]),
    );
  }
}

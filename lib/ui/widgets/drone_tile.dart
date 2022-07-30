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
      subtitle:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(drone.manufacturer!),
        Text('Serviced: ${drone.serviced!}'),
        Text('Date Acquired: ${drone.acquisitionDate!}'),
      ]),
    );
  }
}

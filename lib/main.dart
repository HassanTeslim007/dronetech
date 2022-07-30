import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ui/screens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(
      home: HomePage()
    )
  );
}

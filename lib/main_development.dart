import 'package:ecommerce_app/bootstrap.dart';
import 'package:ecommerce_app/src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  bootstrap(() => const App());
}

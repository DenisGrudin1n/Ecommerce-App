import 'package:ecommerce_app/bootstrap.dart';
import 'package:ecommerce_app/src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();

  bootstrap(() => const App());
}

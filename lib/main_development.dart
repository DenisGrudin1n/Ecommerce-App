import 'package:ecommerce_app/bootstrap.dart';
import 'package:ecommerce_app/src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();
  await Hive.openBox<int>('favorites');

  await bootstrap(() => const App());
}

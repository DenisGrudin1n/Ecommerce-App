import 'package:ecommerce_app/bootstrap.dart';
import 'package:ecommerce_app/src/app/app.dart';
import 'package:ecommerce_app/src/features/home/models/featured_product_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();
  Hive.registerAdapter(FeaturedProductModelAdapter());
  await Hive.openBox<FeaturedProductModel>('favorites');

  await bootstrap(() => const App());
}

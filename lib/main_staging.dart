import 'package:ecommerce_app/bootstrap.dart';
import 'package:ecommerce_app/src/app/app.dart';
import 'package:ecommerce_app/src/features/cart/models/cart_product_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();

  Hive.registerAdapter(CartProductAdapter());

  await Hive.openBox<int>('favorites');
  await Hive.openBox<CartProduct>('cart');

  await bootstrap(() => const App());
}

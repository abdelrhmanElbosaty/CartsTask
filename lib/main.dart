import 'dart:io';

import 'package:flutter/material.dart';

import 'features/carts/ui/carts_page.dart';
import 'features/core/app_injector.dart';
import 'features/core/dio_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartsPage(),
    );
  }
}

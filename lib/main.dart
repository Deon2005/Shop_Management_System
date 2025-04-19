import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // make sure this file exists
import 'screens/billing_screen.dart';
import 'screens/history.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Initialize the database factory for ffi
  sqfliteFfiInit(); // Initialize sqflite FFI
  databaseFactory = databaseFactoryFfi; // Set the factory to FFI version
  runApp(const KarthikaStores());
}

class KarthikaStores extends StatelessWidget {
  const KarthikaStores({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const home_screen(),
      routes: {
        '/billing': (context) => const BillingScreen(),
        '/history': (context) => const History(),
      }, // default screen
    );
  }
}

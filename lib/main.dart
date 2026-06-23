import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FronteraCampoApp());
}

class FronteraCampoApp extends StatelessWidget {
  const FronteraCampoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frontera Campo',
      home: const HomeScreen(),
    );
  }
}
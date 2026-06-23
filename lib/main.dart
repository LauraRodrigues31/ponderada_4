import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().inicializar();
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase não configurado — app funciona em modo offline-first
  }
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
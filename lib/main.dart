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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFFC9A84C),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC9A84C),
          secondary: Color(0xFFC9A84C),
          surface: Color(0xFF1A1A1A),
          onPrimary: Color(0xFF0A0A0A),
          onSurface: Color(0xFFF5F5F0),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0A0A),
          foregroundColor: Color(0xFFF5F5F0),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFFC9A84C),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC9A84C),
            foregroundColor: const Color(0xFF0A0A0A),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1A1A1A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
          labelStyle: const TextStyle(color: Color(0xFF8A8A8A)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFC9A84C)),
          ),
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF1A1A1A)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFC9A84C),
          foregroundColor: Color(0xFF0A0A0A),
        ),
        listTileTheme: const ListTileThemeData(
          tileColor: Color(0xFF1A1A1A),
          iconColor: Color(0xFFC9A84C),
        ),
        dividerColor: const Color(0xFF2A2A2A),
      ),
      home: const HomeScreen(),
    );
  }
}
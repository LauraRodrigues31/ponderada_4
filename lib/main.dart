import 'package:flutter/material.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Frontera Campo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Frontera Campo',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Registro de coletas em campo'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => const SobreScreen()),
                );
              },
              child: const Text('Sobre o app'),
            ),
          ],
        ),
      ),
    );
  }
}

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('app para ajudar os geólogos da minha empresa a registrar suas coletas de campo', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('app caputura foto, pega localização e permite registrar offiline')
          ],
        ),
      ),
    );
  }
}
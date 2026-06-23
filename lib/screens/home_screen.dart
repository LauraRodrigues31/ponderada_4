import 'package:flutter/material.dart';
import 'sobre_screen.dart';

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

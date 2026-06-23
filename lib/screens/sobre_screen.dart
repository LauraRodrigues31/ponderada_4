import 'package:flutter/material.dart';

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

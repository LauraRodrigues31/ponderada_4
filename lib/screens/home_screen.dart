import 'package:flutter/material.dart';
import 'sobre_screen.dart';
import 'nova_coleta_screen.dart';
import 'historico_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FRONTERA',
                style: TextStyle(
                  color: Color(0xFFC9A84C),
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                ),
              ),
              const Text(
                'CAMPO',
                style: TextStyle(
                  color: Color(0xFFF5F5F0),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 6,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFC9A84C), thickness: 1),
              const SizedBox(height: 8),
              const Text(
                'Registro de coletas geológicas',
                style: TextStyle(color: Color(0xFF8A8A8A), fontSize: 14),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NovaColetaScreen()),
                    );
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Nova Coleta'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HistoricoScreen()),
                    );
                  },
                  icon: const Icon(Icons.history),
                  label: const Text('Histórico'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SobreScreen()),
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Sobre o app'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

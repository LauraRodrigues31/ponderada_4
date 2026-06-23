import 'dart:io';
import 'package:flutter/material.dart';
import '../models/coleta.dart';

class DetalheScreen extends StatelessWidget {
  const DetalheScreen({super.key, required this.coleta});

  final Coleta coleta;

  String _formatarDataHora(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year} '
        '${data.hour.toString().padLeft(2, '0')}:'
        '${data.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe da Coleta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (coleta.fotoPath != null)
              Image.file(
                File(coleta.fotoPath!),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            if (coleta.fotoPath != null) const SizedBox(height: 16),
            Text(
              coleta.nome,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.layers, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(coleta.tipoRocha),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(_formatarDataHora(coleta.dataHora)),
              ],
            ),
            if (coleta.latitude != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 18, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Lat: ${coleta.latitude!.toStringAsFixed(4)}, '
                    'Long: ${coleta.longitude!.toStringAsFixed(4)}',
                  ),
                ],
              ),
            ],
            if (coleta.observacoes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.notes, size: 18, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(child: Text(coleta.observacoes)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

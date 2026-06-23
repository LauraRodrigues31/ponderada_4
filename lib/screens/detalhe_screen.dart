import 'dart:io';
import 'package:flutter/material.dart';
import '../models/coleta.dart';
import '../services/share_service.dart';

class DetalheScreen extends StatelessWidget {
  const DetalheScreen({super.key, required this.coleta});

  final Coleta coleta;

  static final _shareService = ShareService();

  String _formatarDataHora(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year} '
        '${data.hour.toString().padLeft(2, '0')}:'
        '${data.minute.toString().padLeft(2, '0')}';
  }

  Widget _fotoOuPlaceholder() {
    if (coleta.fotoPath == null) return const SizedBox.shrink();
    if (File(coleta.fotoPath!).existsSync()) {
      return Image.file(
        File(coleta.fotoPath!),
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return Container(
      height: 250,
      color: Colors.grey[200],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image, size: 48, color: Colors.grey),
          SizedBox(height: 8),
          Text('Foto não disponível', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final foto = _fotoOuPlaceholder();
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe da Coleta')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _shareService.compartilharColeta(coleta),
        child: const Icon(Icons.share),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            foto,
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
            if (coleta.temperatura != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.thermostat, size: 18, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    '${coleta.temperatura!.toStringAsFixed(0)}°C • ${coleta.descricaoClima ?? ''}',
                  ),
                ],
              ),
            ],
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

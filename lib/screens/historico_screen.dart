import 'dart:io';
import 'package:flutter/material.dart';
import '../models/coleta.dart';
import '../services/coleta_service.dart';
import 'detalhe_screen.dart';

class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  final _coletaService = ColetaService();
  List<Coleta>? _coletas;

  @override
  void initState() {
    super.initState();
    _carregarColetas();
  }

  Future<void> _carregarColetas() async {
    final coletas = await _coletaService.buscarColetas();
    setState(() => _coletas = coletas);
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      body: _coletas == null
          ? const Center(child: CircularProgressIndicator())
          : _coletas!.isEmpty
              ? const Center(child: Text('Nenhuma coleta registrada ainda.'))
              : ListView.builder(
                  itemCount: _coletas!.length,
                  itemBuilder: (context, index) {
                    final coleta = _coletas![index];
                    return ListTile(
                      leading: coleta.fotoPath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.file(
                                File(coleta.fotoPath!),
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.description),
                      title: Text(coleta.nome),
                      subtitle: Text(
                        '${coleta.tipoRocha} • ${_formatarData(coleta.dataHora)}',
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalheScreen(coleta: coleta),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

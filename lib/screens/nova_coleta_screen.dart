import 'dart:io';
import 'package:flutter/material.dart';
import '../models/clima.dart';
import '../models/coleta.dart';
import '../services/camera_service.dart';
import '../services/coleta_service.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

class NovaColetaScreen extends StatefulWidget {
  const NovaColetaScreen({super.key});

  @override
  State<NovaColetaScreen> createState() => _NovaColetaScreenState();
}

class _NovaColetaScreenState extends State<NovaColetaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _cameraService = CameraService();
  final _locationService = LocationService();
  final _coletaService = ColetaService();
  final _weatherService = WeatherService();
  String? _tipoRocha;
  String? _fotoPath;
  double? _latitude;
  double? _longitude;
  Clima? _clima;
  bool _carregandoClima = false;
  bool _salvando = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  Future<void> _adicionarFoto() async {
    final path = await _cameraService.tirarFoto();
    if (path != null) {
      setState(() => _fotoPath = path);
    }
  }

  Future<void> _capturarLocalizacao() async {
    final posicao = await _locationService.capturarLocalizacao();
    if (posicao != null) {
      setState(() {
        _latitude = posicao.latitude;
        _longitude = posicao.longitude;
        _clima = null;
        _carregandoClima = true;
      });
      await _buscarClima(posicao.latitude, posicao.longitude);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('GPS indisponível. Verifique se a localização está ativada.'),
        ),
      );
    }
  }

  Future<void> _buscarClima(double lat, double lon) async {
    final dados = await _weatherService.buscarClima(lat, lon);
    if (!mounted) return;
    setState(() {
      _carregandoClima = false;
      _clima = dados != null ? Clima.fromMap(dados) : null;
    });
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);

    final coleta = Coleta(
      nome: _nomeController.text.trim(),
      observacoes: _observacoesController.text.trim(),
      tipoRocha: _tipoRocha ?? 'Indefinida',
      fotoPath: _fotoPath,
      latitude: _latitude,
      longitude: _longitude,
      dataHora: DateTime.now(),
      temperatura: _clima?.temperatura,
      descricaoClima: _clima?.descricao,
    );

    try {
      await _coletaService.salvarColeta(coleta);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coleta salva com sucesso!')),
      );
      _nomeController.clear();
      _observacoesController.clear();
      setState(() {
        _tipoRocha = null;
        _fotoPath = null;
        _latitude = null;
        _longitude = null;
        _clima = null;
        _carregandoClima = false;
        _salvando = false;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar coleta. Tente novamente.')),
      );
      setState(() => _salvando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Coleta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome da coleta'),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Informe o nome da coleta' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _observacoesController,
                decoration: const InputDecoration(labelText: 'Observações'),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _tipoRocha,
                decoration: const InputDecoration(labelText: 'Tipo de rocha'),
                items: const [
                  DropdownMenuItem(value: 'Ígnea', child: Text('Ígnea')),
                  DropdownMenuItem(value: 'Sedimentar', child: Text('Sedimentar')),
                  DropdownMenuItem(value: 'Metamórfica', child: Text('Metamórfica')),
                  DropdownMenuItem(value: 'Indefinida', child: Text('Indefinida')),
                ],
                onChanged: (value) => setState(() => _tipoRocha = value),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: _adicionarFoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Adicionar Foto'),
              ),
              const SizedBox(height: 12),
              _fotoPath != null
                  ? Image.file(
                      File(_fotoPath!),
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                      ),
                    ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _capturarLocalizacao,
                icon: const Icon(Icons.location_on),
                label: const Text('Capturar Localização'),
              ),
              const SizedBox(height: 8),
              _latitude != null
                  ? Text(
                      '📍 Lat: ${_latitude!.toStringAsFixed(4)}, Long: ${_longitude!.toStringAsFixed(4)}',
                    )
                  : const Text(
                      'Localização não capturada',
                      style: TextStyle(color: Colors.grey),
                    ),
              const SizedBox(height: 4),
              if (_carregandoClima)
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else if (_clima != null)
                Text(
                  '🌡️ ${_clima!.temperatura.toStringAsFixed(0)}°C • ${_clima!.descricao}',
                )
              else if (_latitude != null)
                const Text(
                  '🌡️ Clima indisponível',
                  style: TextStyle(color: Colors.grey),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvando ? null : _salvar,
                child: _salvando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Salvar Coleta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NovaColetaScreen extends StatefulWidget {
  const NovaColetaScreen({super.key});

  @override
  State<NovaColetaScreen> createState() => _NovaColetaScreenState();
}

class _NovaColetaScreenState extends State<NovaColetaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _observacoesController = TextEditingController();
  String? _tipoRocha;

  @override
  void dispose() {
    _nomeController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coleta salva com sucesso!')),
      );
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
                onPressed: () {},
                icon: const Icon(Icons.camera_alt),
                label: const Text('Adicionar Foto'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                label: const Text('Capturar Localização'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar Coleta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

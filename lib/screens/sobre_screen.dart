import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frontera Campo',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Registro digital de coletas geológicas em campo',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const Divider(height: 32),
            const Text(
              'O problema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Geólogos de campo registram amostras, coordenadas e observações em cadernos durante as visitas. Depois, no escritório, precisam transcrever tudo para planilhas, organizar centenas de fotos e montar relatórios para a equipe de engenharia. Esse trabalho acumula, os dados ficam desorganizados e as fotos se perdem.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'A solução',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'O Frontera Campo digitaliza o registro no momento da coleta. O geólogo fotografa a amostra, anota a litologia, captura as coordenadas GPS e registra as condições climáticas automaticamente, tudo em um único lugar. Os dados ficam disponíveis para a equipe de escritório assim que o dispositivo tiver conexão.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Funcionalidades',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...[
              'Registro de coletas com nome, tipo de rocha e observações',
              'Captura de foto pela câmera do dispositivo',
              'Captura de coordenadas GPS',
              'Consulta automática de clima via Open-Meteo',
              'Armazenamento offline com SQLite',
              'Sincronização com Firebase quando houver conexão',
              'Compartilhamento de coletas por qualquer app instalado',
            ].map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(height: 1.5)),
                    Expanded(child: Text(item, style: const TextStyle(height: 1.5))),
                  ],
                ),
              ),
            ),
            const Divider(height: 32),
            const Text(
              'Desenvolvido por Laura Rodrigues',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const Text(
              'Ponderada 4 - Desenvolvimento Mobile',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

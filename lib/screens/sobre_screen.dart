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
              'FRONTERA CAMPO',
              style: TextStyle(
                color: Color(0xFFC9A84C),
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Registro digital de coletas geológicas em campo',
              style: TextStyle(fontSize: 15, color: Color(0xFF8A8A8A)),
            ),
            const Divider(height: 32, color: Color(0xFF2A2A2A)),
            const Text(
              'O problema',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFFF5F5F0),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Geólogos de campo registram amostras, coordenadas e observações em cadernos durante as visitas. Depois, no escritório, precisam transcrever tudo para planilhas, organizar centenas de fotos e montar relatórios para a equipe de engenharia. Esse trabalho acumula, os dados ficam desorganizados e as fotos se perdem.',
              style: TextStyle(height: 1.6, color: Color(0xFFBBBBB5)),
            ),
            const SizedBox(height: 20),
            const Text(
              'A solução',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFFF5F5F0),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'O Frontera Campo digitaliza o registro no momento da coleta. O geólogo fotografa a amostra, anota a litologia, captura as coordenadas GPS e registra as condições climáticas automaticamente, tudo em um único lugar. Os dados ficam disponíveis para a equipe de escritório assim que o dispositivo tiver conexão.',
              style: TextStyle(height: 1.6, color: Color(0xFFBBBBB5)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Funcionalidades',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFFF5F5F0),
                letterSpacing: 0.5,
              ),
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
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '— ',
                      style: TextStyle(
                        height: 1.6,
                        color: Color(0xFFC9A84C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          height: 1.6,
                          color: Color(0xFFBBBBB5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 32, color: Color(0xFF2A2A2A)),
            const Text(
              'Desenvolvido por Laura Rodrigues',
              style: TextStyle(color: Color(0xFF8A8A8A), fontSize: 13),
            ),
            const Text(
              'Ponderada 4 — Desenvolvimento Mobile',
              style: TextStyle(color: Color(0xFF8A8A8A), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

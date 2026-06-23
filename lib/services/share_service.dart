import 'package:share_plus/share_plus.dart';
import '../models/coleta.dart';

class ShareService {
  Future<void> compartilharColeta(Coleta coleta) async {
    final texto = _montarTexto(coleta);

    if (coleta.fotoPath != null) {
      await SharePlus.instance.share(ShareParams(
        files: [XFile(coleta.fotoPath!)],
        text: texto,
      ));
    } else {
      await SharePlus.instance.share(ShareParams(text: texto));
    }
  }

  String _montarTexto(Coleta coleta) {
    final data = _formatarDataHora(coleta.dataHora);
    final buffer = StringBuffer()
      ..writeln('📍 Coleta: ${coleta.nome}')
      ..writeln('🪨 Tipo de rocha: ${coleta.tipoRocha}')
      ..writeln('📅 Data: $data');

    if (coleta.temperatura != null) {
      buffer.writeln(
        '🌡️ Clima: ${coleta.temperatura!.toStringAsFixed(0)}°C • ${coleta.descricaoClima}',
      );
    }

    if (coleta.latitude != null) {
      buffer.writeln(
        '📌 Localização: Lat ${coleta.latitude!.toStringAsFixed(4)}, '
        'Long ${coleta.longitude!.toStringAsFixed(4)}',
      );
    }

    if (coleta.observacoes.isNotEmpty) {
      buffer.writeln('📝 Observações: ${coleta.observacoes}');
    }

    buffer
      ..writeln()
      ..write('Registrado pelo Frontera Campo');

    return buffer.toString();
  }

  String _formatarDataHora(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year} '
        '${data.hour.toString().padLeft(2, '0')}:'
        '${data.minute.toString().padLeft(2, '0')}';
  }
}

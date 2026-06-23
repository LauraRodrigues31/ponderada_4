import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/coleta.dart';

class FirebaseService {
  Future<String?> sincronizarColeta(Coleta coleta) async {
    try {
      return await _sincronizar(coleta).timeout(const Duration(seconds: 10));
    } catch (_) {
      return null;
    }
  }

  Future<String?> _sincronizar(Coleta coleta) async {
    // Firebase Storage requer plano Blaze — fotos ficam apenas no dispositivo.
    // Apenas os dados textuais são sincronizados com o Firestore.
    final dados = Map<String, dynamic>.from(coleta.toMap());
    final doc = await FirebaseFirestore.instance
        .collection('coletas')
        .add(dados);
    return doc.id;
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    String? fotoUrl;
    if (coleta.fotoPath != null) {
      final ref = FirebaseStorage.instance.ref(
        'fotos/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await ref.putFile(File(coleta.fotoPath!));
      fotoUrl = await ref.getDownloadURL();
    }

    final dados = coleta.toMap()..['fotoUrl'] = fotoUrl;
    final doc = await FirebaseFirestore.instance
        .collection('coletas')
        .add(dados);
    return doc.id;
  }
}

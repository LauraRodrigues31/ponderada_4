import '../models/coleta.dart';
import '../repositories/coleta_repository.dart';
import 'firebase_service.dart';

class ColetaService {
  final _repository = ColetaRepository();
  final _firebaseService = FirebaseService();

  Future<void> salvarColeta(Coleta coleta) async {
    final id = await _repository.salvar(coleta);
    _sincronizarBackground(id, coleta);
  }

  Future<List<Coleta>> buscarColetas() async {
    return _repository.listarTodas();
  }

  Future<void> _sincronizarBackground(int id, Coleta coleta) async {
    try {
      final firebaseId = await _firebaseService.sincronizarColeta(coleta);
      if (firebaseId != null) {
        await _repository.atualizarFirebaseId(id, firebaseId);
      }
    } catch (_) {
      // falha silenciosa — offline-first
    }
  }
}

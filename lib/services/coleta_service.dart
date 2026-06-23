import '../models/coleta.dart';
import '../repositories/coleta_repository.dart';

class ColetaService {
  final _repository = ColetaRepository();

  Future<void> salvarColeta(Coleta coleta) async {
    await _repository.salvar(coleta);
  }

  Future<List<Coleta>> buscarColetas() async {
    return _repository.listarTodas();
  }
}

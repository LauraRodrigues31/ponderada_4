import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/coleta.dart';

class ColetaRepository {
  Future<Database> get _db async {
    final caminho = join(await getDatabasesPath(), 'frontera_campo.db');
    return openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE coletas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          observacoes TEXT,
          tipoRocha TEXT,
          fotoPath TEXT,
          latitude REAL,
          longitude REAL,
          dataHora TEXT
        )
      '''),
    );
  }

  Future<int> salvar(Coleta coleta) async {
    final db = await _db;
    return db.insert('coletas', coleta.toMap());
  }

  Future<List<Coleta>> listarTodas() async {
    final db = await _db;
    final maps = await db.query('coletas', orderBy: 'dataHora DESC');
    return maps.map(Coleta.fromMap).toList();
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/coleta.dart';

class ColetaRepository {
  Future<Database> get _db async {
    final caminho = join(await getDatabasesPath(), 'frontera_campo.db');
    return openDatabase(
      caminho,
      version: 2,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE coletas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          observacoes TEXT,
          tipoRocha TEXT,
          fotoPath TEXT,
          latitude REAL,
          longitude REAL,
          dataHora TEXT,
          temperatura REAL,
          descricaoClima TEXT,
          firebaseId TEXT
        )
      '''),
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE coletas ADD COLUMN temperatura REAL');
          await db.execute('ALTER TABLE coletas ADD COLUMN descricaoClima TEXT');
          await db.execute('ALTER TABLE coletas ADD COLUMN firebaseId TEXT');
        }
      },
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

  Future<void> atualizarFirebaseId(int id, String firebaseId) async {
    final db = await _db;
    await db.update(
      'coletas',
      {'firebaseId': firebaseId},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class Coleta {
  final int? id;
  final String nome;
  final String observacoes;
  final String tipoRocha;
  final String? fotoPath;
  final double? latitude;
  final double? longitude;
  final DateTime dataHora;

  Coleta({
    this.id,
    required this.nome,
    required this.observacoes,
    required this.tipoRocha,
    this.fotoPath,
    this.latitude,
    this.longitude,
    required this.dataHora,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'observacoes': observacoes,
      'tipoRocha': tipoRocha,
      'fotoPath': fotoPath,
      'latitude': latitude,
      'longitude': longitude,
      'dataHora': dataHora.toIso8601String(),
    };
  }

  factory Coleta.fromMap(Map<String, dynamic> map) {
    return Coleta(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      observacoes: map['observacoes'] as String,
      tipoRocha: map['tipoRocha'] as String,
      fotoPath: map['fotoPath'] as String?,
      latitude: map['latitude'] as double?,
      longitude: map['longitude'] as double?,
      dataHora: DateTime.parse(map['dataHora'] as String),
    );
  }
}

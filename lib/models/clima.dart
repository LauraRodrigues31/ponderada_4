class Clima {
  final double temperatura;
  final int weatherCode;

  Clima({required this.temperatura, required this.weatherCode});

  factory Clima.fromMap(Map<String, dynamic> map) {
    final current = map['current'] as Map<String, dynamic>;
    return Clima(
      temperatura: (current['temperature_2m'] as num).toDouble(),
      weatherCode: current['weathercode'] as int,
    );
  }

  String get descricao {
    if (weatherCode == 0) return 'Céu limpo';
    if (weatherCode <= 3) return 'Parcialmente nublado';
    if (weatherCode <= 48) return 'Névoa';
    if (weatherCode <= 67) return 'Chuva';
    if (weatherCode <= 77) return 'Neve';
    if (weatherCode <= 82) return 'Pancadas de chuva';
    if (weatherCode <= 99) return 'Tempestade';
    return 'Condição desconhecida';
  }
}

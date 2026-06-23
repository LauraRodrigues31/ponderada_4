import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> inicializar() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(settings);
  }

  Future<void> notificarSyncConcluido(String nomeColeta) async {
    const detalhesAndroid = AndroidNotificationDetails(
      'sync_channel',
      'Sincronização',
      importance: Importance.high,
      priority: Priority.high,
    );
    const detalhes = NotificationDetails(
      android: detalhesAndroid,
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(
      1,
      'Coleta sincronizada ✓',
      '$nomeColeta foi salva na nuvem com sucesso',
      detalhes,
    );
  }
}

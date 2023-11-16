import 'dart:developer';
import 'package:logging/logging.dart';

void logger(String message, {bool error = false}) {
  print(
    '[${DateTime.now().toIso8601String()}] ${error ? 'ERROR' : 'INFO'}: $message',
  );
  // log(
  //   message,
  //   name: 'Server',
  //   level: error ? Level.INFO.value : Level.SEVERE.value,
  // );
}

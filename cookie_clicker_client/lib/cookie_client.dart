import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_clicker_client/logger.dart';

typedef Command = ({String command, String value});
typedef DataCallback = void Function(Command data, String? error);

class CookieClient {
  Socket? _socket;
  final List<DataCallback> _listeners = [];

  Future<void> connect({
    required InternetAddress address,
    required int port,
  }) async {
    _socket = await Socket.connect(address, port);
    _socket!.listen(
      _onData,
      onDone: () => _sendToAll((command: '', value: ''), 'Connection closed'),
      onError: (error) => _sendToAll((command: '', value: ''), '$error'),
    );
  }

  void addListener(DataCallback listener) {
    _listeners.add(listener);
  }

  void _sendToAll(Command data, String? error) {
    for (DataCallback listener in _listeners) {
      listener(data, error);
    }
  }

  void _onData(Uint8List data) {
    logger('Received data: $data');
    try {
      final parsed = utf8.decode(data);
      logger('Parsed data: $parsed');
      final index = parsed.indexOf(':');
      if (index == -1) {
        logger('Invalid command format');
      } else {
        final command = parsed.substring(0, index);
        final value = parsed.substring(index + 1).trim();
        _sendToAll((command: command, value: value), null);
      }
    } catch (e) {
      logger('Error parsing data from: $e', error: true);
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_clicker_client/logger.dart';

typedef Command = ({String command, String value});
typedef DataCallback = void Function(Command data);

class CookieClient {
  Socket? _socket;
  final List<DataCallback> _listeners = [];
  final StreamController<bool> _connection = StreamController<bool>.broadcast();

  Stream<bool> get connection => _connection.stream;

  Future<void> connect({
    required InternetAddress address,
    required int port,
  }) async {
    _socket = await Socket.connect(address, port);
    _connection.add(true);
    _socket!.listen(
      _onData,
      onDone: () => _handleDisconnect,
      onError: (e) => _handleDisconnect,
    );
  }

  void send(Command command) {
    final data = '${command.command}:${command.value}';
    logger('Sending data: $data');
    if (_socket == null) {
      logger('Unable to send. Socket is null.', error: true);
    } else {
      _socket!.write(utf8.encode(data));
    }
  }

  void addListener(DataCallback listener) {
    _listeners.add(listener);
  }

  void _handleDisconnect() {
    _connection.add(false);
    _socket!.destroy();
    _socket = null;
  }

  void _sendToAll(Command data, String? error) {
    for (DataCallback listener in _listeners) {
      listener(data);
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

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_clicker_client/logger.dart';
import 'package:get/get.dart';

typedef Command = ({String command, String value});
typedef DataCallback = void Function(Command data);

class CookieClient {
  Socket? _socket;
  final List<DataCallback> _listeners = [];
  final RxBool connected = RxBool(false);

  Future<void> connect({
    required InternetAddress address,
    required int port,
  }) async {
    try {
      _socket = await Socket.connect(
        address,
        port,
        timeout: const Duration(seconds: 10),
      );
      connected.value = true;
      // Catch errors on the socket
      _socket!.listen(
        _onData,
        onError: (e) {
          logger('Error on socket: $e', error: true);
          _handleDisconnect();
        },
        onDone: () {
          logger('Socket done');
          _handleDisconnect();
        },
      );
    } catch (e) {
      logger('Error connecting to server: $e', error: true);
      rethrow;
    }
  }

  void send(Command command) {
    try {
      final data = '${command.command}:${command.value}\n';
      logger('Sending data: $data');
      if (_socket == null) {
        logger('Unable to send. Socket is null.', error: true);
      } else {
        _socket!.add(utf8.encode(data));
      }
    } catch (e) {
      logger('Error sending data: $e', error: true);
      connected.value = false;
    }
  }

  void addListener(DataCallback listener) {
    _listeners.add(listener);
  }

  void _handleDisconnect() {
    connected.value = false;
    _socket?.destroy();
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
      for (String line in parsed.split('\n')) {
        if (line.isNotEmpty) {
          final index = line.indexOf(':');
          if (index == -1) {
            logger('Invalid command format');
          } else {
            final command = line.substring(0, index);
            final value = line.substring(index + 1).trim();
            _sendToAll((command: command, value: value), null);
          }
        }
      }
    } catch (e) {
      logger('Error parsing data from: $e', error: true);
    }
  }
}

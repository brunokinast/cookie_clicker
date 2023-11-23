import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_clicker_server/cookie_server.dart';
import 'package:cookie_clicker_server/logger.dart';

class CookieWebserver implements CookieServer {
  final int _port;
  final Map<String, WebSocket> _clients = {};
  final List<DataCallback> _listeners = [];

  int _lastId = 0;

  CookieWebserver(this._port);

  @override
  Future<void> start() async {
    HttpServer server = await HttpServer.bind(InternetAddress.anyIPv4, _port);

    logger('Server started on ${server.address.address}:${server.port}');

    server.transform(WebSocketTransformer()).listen(_addClient);
  }

  @override
  void addListener(DataCallback listener) {
    _listeners.add(listener);
  }

  @override
  void sendToAll(Command command) {
    final data = utf8.encode('${command.command}:${command.value}\n');
    for (WebSocket client in _clients.values) {
      client.add(data);
    }
  }

  void _addClient(WebSocket client) {
    String address = '${_lastId++}';
    logger('Client connected: $address');

    _clients[address] = client;

    client.listen(
      (data) => _onData(address, data),
      onDone: () {
        logger('Client $address disconnected.');
        _clients.remove(client);
        client.close();
      },
      onError: (error) {
        logger('Client $address error: $error', error: true);
        _clients.remove(client);
        client.close();
      },
    );
  }

  void _onData(String address, Uint8List data) {
    logger('Received data from $address: $data');
    try {
      final parsed = utf8.decode(data);
      logger('Parsed data from $address: $parsed');
      for (String line in parsed.split('\n')) {
        if (line.isNotEmpty) {
          final index = line.indexOf(':');
          if (index == -1) {
            throw Exception('Invalid command format');
          } else {
            final command = line.substring(0, index);
            final value = line.substring(index + 1).trim();
            for (DataCallback listener in _listeners) {
              listener(address, (command: command, value: value));
            }
          }
        }
      }
    } catch (e) {
      logger('Error parsing data from $address: $data\n$e', error: true);
    }
  }
}

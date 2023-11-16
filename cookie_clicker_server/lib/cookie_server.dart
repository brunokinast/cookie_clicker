import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookie_clicker_server/logger.dart';

typedef Command = ({String command, String value});
typedef DataCallback = void Function(String address, Command data);

class CookieServer {
  final int port;
  final Map<String, Socket> _clients = {};
  final List<DataCallback> _listeners = [];

  CookieServer(this.port);

  Future<void> start() async {
    ServerSocket server =
        await ServerSocket.bind(InternetAddress.loopbackIPv4, port);

    server.listen(_addClient);
  }

  void addListener(DataCallback listener) {
    _listeners.add(listener);
  }

  void sendToAll(Command command) {
    final data = utf8.encode('${command.command}:${command.value}');
    for (Socket client in _clients.values) {
      client.add(data);
    }
  }

  void _addClient(Socket client) {
    String address = '${client.remoteAddress.address}:${client.remotePort}';
    logger('Client connected: $address');

    _clients[address] = client;

    client.listen(
      (data) => _onData(address, data),
      onDone: () {
        logger('Client $address disconnected.');
        _clients.remove(client);
        client.destroy();
      },
      onError: (error) {
        logger('Client $address error: $error', error: true);
        _clients.remove(client);
        client.destroy();
      },
    );
  }

  void _onData(String address, Uint8List data) {
    logger('Received data from $address: $data');
    try {
      final parsed = utf8.decode(data);
      logger('Parsed data from $address: $parsed');
      final index = parsed.indexOf(':');
      if (index == -1) {
        throw Exception('Invalid command format');
      } else {
        final command = parsed.substring(0, index);
        final value = parsed.substring(index + 1).trim();
        for (DataCallback listener in _listeners) {
          listener(address, (command: command, value: value));
        }
      }
    } catch (e) {
      logger('Error parsing data from $address: $data\n$e', error: true);
    }
  }
}

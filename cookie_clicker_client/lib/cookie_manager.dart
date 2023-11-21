import 'dart:async';

import 'package:cookie_clicker_client/cookie_client.dart';

enum ServerAction {
  click,
  register,
  buy,
}

enum ClientAction {
  announce,
  count,
  updateItem,
}

class CookieManager {
  final CookieClient _client;
  final StreamController<String> _announcements;
  final StreamController<int> _count;

  Stream<String> get announcements => _announcements.stream;
  Stream<int> get count => _count.stream;

  CookieManager(this._client)
      : _announcements = StreamController.broadcast(),
        _count = StreamController.broadcast() {
    _client.addListener((data, error) {
      if (error == null) _onData(data);
    });
  }

  void _onData(Command data) {
    if (data.command == ClientAction.count.name) {
      _count.add(int.parse(data.value));
    } else if (data.command == ClientAction.announce.name) {
      _announcements.add(data.value);
    }
  }
}

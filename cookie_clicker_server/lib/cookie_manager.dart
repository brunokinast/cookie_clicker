import 'dart:async';
import 'dart:math' as math;

import 'package:cookie_clicker_server/cookie_item.dart';
import 'package:cookie_clicker_server/cookie_server.dart';
import 'package:collection/collection.dart';

enum ServerAction {
  click,
  register,
  buy,
}

enum ClientAction {
  announce,
  count,
  updateQuantity,
}

class CookieManager {
  final CookieServer _server;
  final Map<String, String> _names = {};
  final List<CookieItem> _items = allItems;

  int _cookies;

  CookieManager(this._server) : _cookies = 10 {
    _server.addListener(_onData);
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  void _sendCookies(int amount) {
    _server.sendToAll((command: ClientAction.count.name, value: '$amount'));
  }

  void _sendItem(CookieItem item) {
    _server.sendToAll((
      command: ClientAction.updateQuantity.name,
      value: '${item.uniqueName}:${item.owned}'
    ));
  }

  void _sendAnnouncement(String message) {
    _server.sendToAll((command: ClientAction.announce.name, value: message));
  }

  void _setCookies(int amount) {
    if (amount != _cookies) {
      _sendCookies(amount);
    }
    _cookies = amount;
  }

  void _onTimer(Timer timer) {
    final generated = _items.fold<int>(
      0,
      (sum, item) => sum + item.owned * item.cookieSecond,
    );
    _setCookies(_cookies + generated);
  }

  void _onData(String address, Command data) {
    if (!_names.containsKey(address)) {
      _names[address] = 'Unknown';
      _sendCookies(_cookies);
      _items.forEach(_sendItem);
    }

    if (data.command == ServerAction.click.name) {
      _onClick(address);
    } else if (data.command == ServerAction.register.name) {
      _onRegister(address, data.value);
    } else if (data.command == ServerAction.buy.name) {
      _onBuy(address, data.value);
    }
  }

  void _onBuy(String address, String itemName) {
    final item = _items.firstWhereOrNull((item) => item.uniqueName == itemName);
    if (item != null) {
      final price = (item.basePrice * math.pow(1.15, item.owned)).ceil();
      if (price <= _cookies) {
        _setCookies(_cookies - price);
        item.owned++;
        _sendAnnouncement('${_names[address]} bought a ${item.name}.');
        _sendItem(item);
      }
    }
  }

  void _onClick(String address) {
    _setCookies(_cookies + 1);
  }

  void _onRegister(String address, String name) {
    _names[address] = name;
    _sendAnnouncement('$name has joined the game.');
  }
}

import 'dart:async';

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
  updateItem,
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

  void _onTimer(Timer timer) {
    _cookies += _items.fold<int>(0, (sum, item) => sum + item.owned * item.cookieSecond);
    _server.sendToAll((command: ClientAction.count.name, value: '$_cookies'));
  }

  void _onData(String address, Command data) {
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
      if (item.price <= _cookies) {
        _cookies -= item.price;
        item.owned++;
        _server.sendToAll((command: ClientAction.announce.name, value: '${_getAddressName(address)} bought a ${item.name}.'));
        _server.sendToAll((command: ClientAction.updateItem.name, value: '${item.uniqueName}:${item.price}'));
      }
    }
  }

  void _onClick(String address) {
    _cookies++;
    _server.sendToAll((
      command: ClientAction.count.name,
      value: '$_cookies',
    ));
  }

  void _onRegister(String address, String name) {
    _names[address] = name;
    _server.sendToAll((
      command: ClientAction.announce.name,
      value: '$name has joined the game.',
    ));
  }

  String _getAddressName(String address) {
    final name = _names[address];
    if (name == null) {
      return 'Unknown';
    } else {
      return name;
    }
  }
}

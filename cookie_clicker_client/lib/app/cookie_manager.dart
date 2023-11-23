import 'package:cookie_clicker_client/app/cookie_client.dart';
import 'package:cookie_clicker_client/app/cookie_item.dart';
import 'package:get/get.dart';

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
  final CookieClient _client;
  final List<CookieItem> items = allItems;

  final RxList<String> announcements = RxList([]);
  final RxInt count = RxInt(0);

  CookieManager(this._client) {
    _client.addListener(_onData);
  }

  void register(String name) {
    _client.send((command: ServerAction.register.name, value: name));
  }

  void click() {
    _client.send((command: ServerAction.click.name, value: ''));
  }

  void buy(CookieItem item) {
    _client.send((command: ServerAction.buy.name, value: item.uniqueName));
  }

  void _onData(Command data) {
    if (data.command == ClientAction.count.name) {
      count.value = int.parse(data.value);
    } else if (data.command == ClientAction.announce.name) {
      announcements.add(data.value);
    } else if (data.command == ClientAction.updateQuantity.name) {
      // Data is in the format of: uniqueName:quantity
      final index = data.value.indexOf(':');
      if (index > -1) {
        final uniqueName = data.value.substring(0, index);
        final quantity = int.parse(data.value.substring(index + 1));
        final item = items.firstWhere((item) => item.uniqueName == uniqueName);
        item.owned.value = quantity;
      }
    }
  }
}

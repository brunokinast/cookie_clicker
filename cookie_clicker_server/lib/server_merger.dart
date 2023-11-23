import 'package:cookie_clicker_server/cookie_server.dart';

class ServerMerger implements CookieServer {
  final CookieServer _server1;
  final CookieServer _server2;

  ServerMerger(this._server1, this._server2);

  @override
  void addListener(DataCallback listener) {
    _server1.addListener(listener);
    _server2.addListener(listener);
  }

  @override
  void sendToAll(Command command) {
    _server1.sendToAll(command);
    _server2.sendToAll(command);
  }

  @override
  Future<void> start() async {
    await _server1.start();
    await _server2.start();
  }
}

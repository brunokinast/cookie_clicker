import 'package:cookie_clicker_server/cookie_manager.dart';
import 'package:cookie_clicker_server/cookie_server.dart';

void main(List<String> arguments) async {
  final cookieServer = CookieServer(6789);
  await cookieServer.start();
  CookieManager(cookieServer);
}

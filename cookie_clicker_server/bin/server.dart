import 'package:cookie_clicker_server/cookie_manager.dart';
import 'package:cookie_clicker_server/cookie_server.dart';
import 'package:cookie_clicker_server/cookie_webserver.dart';
import 'package:cookie_clicker_server/server_merger.dart';

void main(List<String> arguments) async {
  final cookieServer = CookieServer(6789);
  final cookieWebserver = CookieWebserver(6790);
  final serverMerged = ServerMerger(cookieServer, cookieWebserver);
  await serverMerged.start();
  CookieManager(ServerMerger(cookieServer, cookieWebserver));
}

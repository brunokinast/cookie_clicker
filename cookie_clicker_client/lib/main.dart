import 'package:cookie_clicker_client/app/cookie_client.dart';
import 'package:cookie_clicker_client/app/cookie_manager.dart';
import 'package:cookie_clicker_client/app/cookie_webclient.dart';
import 'package:cookie_clicker_client/widgets/connection_page.dart';
import 'package:cookie_clicker_client/widgets/cookie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  final CookieClient client;

  if (kIsWeb) {
    client = CookieWebclient();
  } else {
    client = CookieClient();
  }

  final CookieManager manager = CookieManager(client);

  runApp(CookieClicker(
    cookieClient: client,
    cookieManager: manager,
  ));
}

class CookieClicker extends StatelessWidget {
  final CookieClient cookieClient;
  final CookieManager cookieManager;

  const CookieClicker({
    super.key,
    required this.cookieClient,
    required this.cookieManager,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookie Clicker Multiplayer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ConnectionPage(
        client: cookieClient,
        manager: cookieManager,
        child: CookiePage(manager: cookieManager),
      ),
    );
  }
}

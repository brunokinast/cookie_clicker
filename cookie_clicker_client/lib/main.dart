import 'package:cookie_clicker_client/app/cookie_client.dart';
import 'package:cookie_clicker_client/app/cookie_manager.dart';
import 'package:cookie_clicker_client/widgets/connection_page.dart';
import 'package:cookie_clicker_client/widgets/cookie_page.dart';
import 'package:flutter/material.dart';

final CookieClient cookieClient = CookieClient();
final CookieManager cookieManager = CookieManager(cookieClient);

void main() {
  runApp(const CookieClicker());
}

class CookieClicker extends StatelessWidget {
  const CookieClicker({super.key});

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
        child: CookiePage(manager: cookieManager),
      ),
    );
  }
}

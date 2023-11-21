import 'package:cookie_clicker_client/app/cookie_manager.dart';
import 'package:cookie_clicker_client/widgets/cookie_store_page.dart';
import 'package:flutter/material.dart';

class CookiePage extends StatelessWidget {
  final CookieManager manager;

  const CookiePage({
    super.key,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookie Clicker Multiplayer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CookieStorePage(manager: manager),
              ),
            ),
            child: const Text('Store'),
          ),
          StreamBuilder<int>(
            stream: manager.count,
            initialData: 0,
            builder: (context, snapshot) {
              return Text(
                'Cookies: ${snapshot.data}',
              );
            },
          ),
          ElevatedButton(
            onPressed: manager.click,
            child: const Text('Click'),
          ),
        ],
      ),
    );
  }
}

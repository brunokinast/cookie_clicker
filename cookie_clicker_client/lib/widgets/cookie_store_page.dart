import 'dart:math' as math;

import 'package:cookie_clicker_client/app/cookie_manager.dart';
import 'package:flutter/material.dart';

class CookieStorePage extends StatelessWidget {
  final CookieManager manager;

  const CookieStorePage({
    super.key,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookie Clicker Multiplayer'),
      ),
      body: StreamBuilder<int>(
          stream: manager.count,
          builder: (context, cookieCount) {
            return ListView.builder(
              itemCount: manager.items.length,
              itemBuilder: (context, index) {
                final item = manager.items[index];
                return StreamBuilder<int>(
                  stream: item.owned,
                  initialData: 0,
                  builder: (context, quantity) {
                    final price =
                        (item.basePrice * math.pow(1.15, quantity.data!))
                            .ceil();
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.description),
                      leading: Text('${quantity.data}'),
                      trailing: Text('Cost: $price'),
                      onTap: cookieCount.data! >= price
                          ? () => manager.buy(item)
                          : null,
                    );
                  },
                );
              },
            );
          }),
    );
  }
}

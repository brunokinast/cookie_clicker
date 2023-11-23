import 'package:cookie_clicker_client/app/cookie_manager.dart';
import 'package:cookie_clicker_client/widgets/announcement.dart';
import 'package:cookie_clicker_client/widgets/cookie_button.dart';
import 'package:cookie_clicker_client/widgets/item_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CookiePage extends StatelessWidget {
  final CookieManager manager;

  const CookiePage({
    super.key,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ItemStore(manager: manager),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Builder(builder: (context) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      color: Colors.white,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                    const Text(
                      'Store',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: Colors.black54,
                        child: Column(
                          children: [
                            Obx(() {
                              final count = manager.count.value;
                              final formatted = NumberFormat().format(count);
                              return Text(
                                '$formatted cookies',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              );
                            }),
                            Obx(() {
                              // Display cookies per second
                              final cps = manager.items.fold(
                                0,
                                (sum, item) =>
                                    sum + item.cookieSecond * item.owned.value,
                              );
                              final formatted = NumberFormat().format(cps);
                              return Text(
                                '$formatted c/s',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      CookieButton(manager: manager),
                    ],
                  ),
                ),
                Announcement(manager: manager),
              ],
            ),
          );
        }),
      ),
    );
  }
}

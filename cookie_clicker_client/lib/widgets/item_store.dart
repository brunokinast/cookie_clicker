import 'dart:math' as math;

import 'package:cookie_clicker_client/app/cookie_manager.dart';
import 'package:cookie_clicker_client/widgets/stone_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ItemStore extends StatelessWidget {
  final CookieManager manager;

  const ItemStore({
    super.key,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/wood.png'),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: SafeArea(
        child: ListView.separated(
          itemCount: manager.items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = manager.items[index];
            return Obx(() {
              final quantity = item.owned.value;
              final count = manager.count.value;
              final price = (item.basePrice * math.pow(1.15, quantity)).ceil();
              final enabled = count >= price;
              return StoneButton(
                enabled: enabled,
                tooltip: item.description,
                onPressed: () => manager.buy(item),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/${item.uniqueName}.gif',
                      width: 50,
                      height: 50,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                              height: 1,
                            ),
                          ),
                          Text(
                            '${NumberFormat().format(price)} cookies',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.bold,
                              height: 1,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        NumberFormat().format(quantity),
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

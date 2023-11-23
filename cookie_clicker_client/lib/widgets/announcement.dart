import 'package:cookie_clicker_client/app/cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Announcement extends StatelessWidget {
  final CookieManager manager;

  const Announcement({
    super.key,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Obx(() {
          final announcements =
              [...manager.announcements.reversed, '', '', ''].take(3).toList();
          double opacity = 1;
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wood.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Center(
              child: Column(
                children: [
                  for (final announcement in announcements)
                    Opacity(
                      opacity: 1 * (opacity -= 0.2),
                      child: Text(
                        announcement,
                        style: TextStyle(
                          fontSize: 24 * opacity,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
        const Positioned(
          top: -15,
          left: 15,
          child: Text(
            'News',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

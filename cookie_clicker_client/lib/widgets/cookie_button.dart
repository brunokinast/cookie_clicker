import 'package:cookie_clicker_client/app/cookie_manager.dart';
import 'package:flutter/material.dart';

class CookieButton extends StatefulWidget {
  final CookieManager manager;

  const CookieButton({
    super.key,
    required this.manager,
  });

  @override
  State<CookieButton> createState() => _CookieButtonState();
}

class _CookieButtonState extends State<CookieButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    scaleAnimation = Tween(
      begin: 1.0,
      end: 1.1,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.ease,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller!.forward();
      },
      onTapUp: (_) {
        _controller!.reverse();
      },
      onTap: () {
        widget.manager.click();
      },
      child: Transform.scale(
        scale: scaleAnimation!.value,
        child: Image.asset(
          'assets/cookie_shine.png',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}

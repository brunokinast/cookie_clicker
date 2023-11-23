import 'package:flutter/material.dart';

class StoneButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool enabled;
  final String tooltip;

  const StoneButton({
    super.key,
    this.enabled = true,
    required this.child,
    required this.onPressed,
    this.tooltip = '',
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                enabled ? 'assets/tile.png' : 'assets/tile_disabled.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Opacity(
            opacity: enabled ? 1 : 0.5,
            child: child,
          ),
        ),
      ),
    );
  }
}

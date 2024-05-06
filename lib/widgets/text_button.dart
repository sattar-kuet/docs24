import 'package:flutter/material.dart';

class InteractiveTextButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const InteractiveTextButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  _InteractiveTextButtonState createState() => _InteractiveTextButtonState();
}

class _InteractiveTextButtonState extends State<InteractiveTextButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _isPressed ? Colors.blue : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: widget.child,
      ),
    );
  }
}

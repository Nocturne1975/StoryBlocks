import 'package:flutter/material.dart';

class InteractiveWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scaleAmount;
  final bool vibrate;

  const InteractiveWrapper({
    super.key,
    required this.child,
    required this.onTap,
    this.scaleAmount = 1.1,
    this.vibrate = false,
  });

  @override
  State<InteractiveWrapper> createState() => _InteractiveWrapperState();
}

class _InteractiveWrapperState extends State<InteractiveWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _vibrate;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1.0, end: widget.scaleAmount).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _vibrate = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handle(bool active) {
    if (active) {
      widget.vibrate ? _controller.repeat(reverse: true) : _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handle(true),
      onExit: (_) => _handle(false),
      child: GestureDetector(
        onTapDown: (_) => _handle(true),
        onTapUp: (_) => _handle(false),
        onTapCancel: () => _handle(false),
        onTap: () async {
          _handle(true);
          await Future.delayed(const Duration(milliseconds: 80));
          widget.onTap();
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            Widget result = Transform.scale(scale: _scale.value, child: widget.child);
            if (widget.vibrate) {
              result = Transform.rotate(angle: _vibrate.value, child: result);
            }
            return result;
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DismissibleAnimatedItem extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final VoidCallback onRemove;

  const DismissibleAnimatedItem({
    super.key,
    required this.child,
    required this.onRemove,
    this.duration = const Duration(
      milliseconds: 350,
    ), // Increased total duration
  });

  @override
  State<DismissibleAnimatedItem> createState() =>
      DismissibleAnimatedItemState();
}

class DismissibleAnimatedItemState extends State<DismissibleAnimatedItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Slide first: runs from 0% to 50% of the total duration
    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0.0)).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
          ),
        );

    // Slide up (second third of duration)
    _slideUpAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.3),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.33, 0.6, curve: Curves.easeInOut),
      ),
    );

    // Then size: runs from 50% to 100% of the total duration
    _sizeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.33, 1.0, curve: Curves.easeInOutQuart),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onRemove();
      }
    });
  }

  void dismiss() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Combine slide left and slide up offsets
        final totalOffset = Offset(
          _slideAnimation.value.dx + _slideUpAnimation.value.dx,
          _slideAnimation.value.dy + _slideUpAnimation.value.dy,
        );
        return SlideTransition(
          position: AlwaysStoppedAnimation(totalOffset),
          child: SizeTransition(
            sizeFactor: _sizeAnimation,
            axisAlignment: 0.0,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

import 'package:flutter/material.dart';

class FadeInSliceFromBottomAnimation extends StatefulWidget {
  final Widget child;
  const FadeInSliceFromBottomAnimation({super.key, required this.child});

  @override
  State<FadeInSliceFromBottomAnimation> createState() => _FadeInSliceFromBottomAnimationState();
}

class _FadeInSliceFromBottomAnimationState extends State<FadeInSliceFromBottomAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.04), // From bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DukoinShimmer extends StatefulWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const DukoinShimmer({
    super.key,
    this.height = 16.0,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  State<DukoinShimmer> createState() => _DukoinShimmerState();
}

class _DukoinShimmerState extends State<DukoinShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..repeat();
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
      builder: (context, _) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: const [0.1, 0.3, 0.4],
              begin: Alignment(-1.0 - 0.3 + (_controller.value * 2), 0.0),
              end: const Alignment(1.0, 0.0),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: widget.borderRadius,
            ),
          ),
        );
      },
    );
  }
}

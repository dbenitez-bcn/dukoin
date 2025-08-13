import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

class DukoinShimmer extends StatefulWidget {
  const DukoinShimmer({
    super.key,
    this.width = double.infinity,
    this.height = 24.0,
  });

  final double width;
  final double height;

  @override
  State<DukoinShimmer> createState() => _DukoinShimmerState();
}

class _DukoinShimmerState extends State<DukoinShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -1.5, max: 1.5, period: const Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).extension<DukoinColors>()!.shimmer,
                Theme.of(context).extension<DukoinColors>()!.shimmerAccent,
                Theme.of(context).extension<DukoinColors>()!.shimmer,
              ],
              stops: [
                _shimmerController.value - 0.5,
                _shimmerController.value,
                _shimmerController.value + 0.5,
              ],
            ),
          ),
        );
      },
    );
  }
}

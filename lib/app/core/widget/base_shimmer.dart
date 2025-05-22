import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer extends StatelessWidget {
  final Duration? duration;
  final double? width;
  final double? height;
  const BaseShimmer({super.key, this.width, this.height, this.duration});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      period: duration ?? const Duration(milliseconds: 1500),
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}

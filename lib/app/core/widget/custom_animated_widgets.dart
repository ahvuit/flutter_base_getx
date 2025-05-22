import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomAnimatedWidgets {
  Widget fadeSlideIn(
      {required Widget child,
      required int position,
      int? delayInMillisecond,
      int? durationInMillisecond,
      double? verticalOffset,
      double? horizontalOffset}) {
    return AnimationConfiguration.staggeredList(
      position: position,
      delay: Duration(milliseconds: delayInMillisecond ?? 200),
      child: FadeInAnimation(
        duration: Duration(milliseconds: durationInMillisecond ?? 400),
        curve: Curves.easeInCubic,
        child: SlideAnimation(
          verticalOffset: verticalOffset,
          horizontalOffset: horizontalOffset,
          duration: Duration(milliseconds: durationInMillisecond ?? 400),
          curve: Curves.easeInCubic,
          child: child,
        ),
      ),
    );
  }
}

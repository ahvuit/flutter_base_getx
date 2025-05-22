import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class BlurFadeScaleTransitionConfiguration extends ModalConfiguration {
  final double blurSigma;
  const BlurFadeScaleTransitionConfiguration({
    super.barrierColor = Colors.black54,
    super.barrierDismissible = true,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.reverseTransitionDuration = const Duration(milliseconds: 300),
    String super.barrierLabel = 'Dismiss',
    this.blurSigma = 5.0,
  });

  @override
  Widget transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: CustomFadeScaleTransition(animation: animation, child: child),
    );
  }
}

class CustomFadeScaleTransition extends StatelessWidget {
  const CustomFadeScaleTransition({
    super.key,
    required this.animation,
    this.child,
  });

  final Animation<double> animation;
  final Widget? child;

  static final Animatable<double> _fadeInTransition = CurveTween(
    curve: const Interval(0.0, 0.3),
  );
  static final Animatable<double> _scaleInTransition = Tween<double>(
    begin: 0.5,
    end: 1.00,
  ).chain(CurveTween(curve: decelerateEasing));
  static final Animatable<double> _fadeOutTransition = Tween<double>(
    begin: 1.0,
    end: 0.0,
  );
  static final Animatable<double> _scaleOutTransition = Tween<double>(
    begin: 1.0,
    end: 0.5,
  ).chain(CurveTween(curve: accelerateEasing));

  @override
  Widget build(BuildContext context) {
    return DualTransitionBuilder(
      animation: animation,
      forwardBuilder: (
        BuildContext context,
        Animation<double> animation,
        Widget? child,
      ) {
        return FadeTransition(
          opacity: _fadeInTransition.animate(animation),
          child: ScaleTransition(
            scale: _scaleInTransition.animate(animation),
            child: child,
          ),
        );
      },
      reverseBuilder: (
        BuildContext context,
        Animation<double> animation,
        Widget? child,
      ) {
        return ScaleTransition(
          scale: _scaleOutTransition.animate(animation),
          child: FadeTransition(
            opacity: _fadeOutTransition.animate(animation),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

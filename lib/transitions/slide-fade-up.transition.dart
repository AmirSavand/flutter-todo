import 'package:flutter/material.dart';

Widget slideFadeUpTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  // Start position (off-screen bottom)
  const Offset begin = Offset(0, 0.1);
  // End position (final position)
  const Offset end = Offset.zero;
  // Easing curve for the animation
  const Curve curve = Curves.easeInOut;
  // Tween to animate from the beginning to the end position
  final Tween<Offset> slideTween = Tween(begin: begin, end: end);
  // Curved animation applying the defined curve
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );
  // Tween for the opacity from a to b
  final Tween<double> opacityTween = Tween(begin: 0, end: 1);
  // Animate the opacity using the same curved animation
  final Animation<double> opacityAnimation = opacityTween.animate(
    curvedAnimation,
  );
  // Create the slide transition
  final slideTransition = SlideTransition(
    position: slideTween.animate(curvedAnimation),
    child: child,
  );
  // Return a FadeTransition wrapping the SlideTransition to apply the fade effect
  return FadeTransition(
    opacity: opacityAnimation,
    child: slideTransition,
  );
}

import 'package:flutter/animation.dart';

class AnimationConstant {
  static const micro = Duration(milliseconds: 180);
  static const selection = Duration(milliseconds: 250);
  static const entrance = Duration(milliseconds: 450);
  static const gridItem = Duration(milliseconds: 380);

  static const staggerStep = 0.07;
  static const staggerMaxStart = 0.45;
  static const entranceSlideOffset = 12.0;
  static const gridSlideOffset = 10.0;

  static const Curve microCurve = Curves.easeOut;
  static const Curve selectionCurve = Curves.easeInOut;
  static const Curve entranceCurve = Curves.easeOutCubic;
  static const Curve gridCurve = Curves.easeOutCubic;
}

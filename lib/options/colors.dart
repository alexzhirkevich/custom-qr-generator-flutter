import 'dart:ui';

import 'package:custom_qr_generator/colors/color.dart';

class QrColors {

  final QrColor dark;
  final QrColor light;
  final QrColor ball;
  final QrColor frame;
  final QrColor background;

  const QrColors({
    this.dark = const QrColorSolid(Color.fromARGB(255, 0, 0, 0)),
    this.light = const QrColorSolid(Color.fromARGB(0, 0, 0, 0)),
    this.ball = const QrColorUnspecified(),
    this.frame = const QrColorUnspecified(),
    this.background = const QrColorSolid(Color.fromARGB(255, 255, 255, 255))
  });

  @override
  bool operator ==(Object other) =>
      other is QrColors &&
          other.dark == dark &&
          other.light == light &&
          other.ball == ball &&
          other.frame == frame;

  @override
  // TODO: implement hashCode
  int get hashCode =>
      (((((dark.hashCode * 31) + light.hashCode) * 31) + ball.hashCode) * 31 +
          frame.hashCode) * 31 + background.hashCode;
}
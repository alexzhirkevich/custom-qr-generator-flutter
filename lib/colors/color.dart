import 'dart:math';
import 'dart:ui';

import 'package:custom_qr_generator/util.dart';

abstract class QrColor {

  const QrColor();

  Paint createPaint(final double width, final double height);

  static const unspecified = QrColorUnspecified();

  static QrColor solid(Color color) => QrColorSolid(color);

  static QrColorLinearGradient linearGradient({
    required List<Color> colors,
    required GradientOrientation orientation
  }) => QrColorLinearGradient(colors: colors, orientation: orientation);

  static QrColorRadialGradient radialGradient({
    required List<Color> colors,
    double radiusFraction = 1
  }) => QrColorRadialGradient(colors: colors, radiusFraction: radiusFraction);

  static QrColorSweepGradient sweepGradient({
    required List<Color> colors
  }) => QrColorSweepGradient(colors: colors);
}

class QrColorUnspecified extends QrColor {

  const QrColorUnspecified();

  @override
  Paint createPaint(double width, double height) =>
      const QrColorSolid(Color.fromARGB(0,0,0,0))
          .createPaint(width, height);

  @override
  bool operator ==(Object other) =>
      other is QrColorUnspecified;

  @override
  int get hashCode => 0;
}

class QrColorSolid extends QrColor {

  final Color color;

  const QrColorSolid(this.color);

  @override
  Paint createPaint(final double width, final double height) {
    Paint p = Paint();
    p.color = color;
    return p;
  }

  @override
  bool operator ==(Object other) =>
      other is QrColorSolid && other.color == color;

  @override
  int get hashCode => color.hashCode;

}

enum GradientOrientation {

  leftDiagonal, rightDiagonal, vertical, horizontal
}

class QrColorLinearGradient extends QrColor {

  final List<Color> colors;
  final GradientOrientation orientation;

  const QrColorLinearGradient({
    required this.colors,
    required this.orientation
  });

  @override
  Paint createPaint(final double width, final double height) {
    final Offset from;
    final Offset to;
    switch (orientation){

      case GradientOrientation.leftDiagonal:
        from = Offset.zero;
        to = Offset(width,height);
        break;
      case GradientOrientation.rightDiagonal:
        from = Offset(width, 0);
        to = Offset(0, height);
        break;
      case GradientOrientation.horizontal:
        from = Offset(0, height/2);
        to = Offset(width, height/2);
        break;
      case GradientOrientation.vertical:
        from = Offset(width/2, 0);
        to = Offset(width/2, height);
        break;
    }

    return Paint()
      ..shader = Gradient.linear(from, to, colors);
  }

  @override
  bool operator ==(Object other) => other is QrColorLinearGradient &&
    other.colors == colors && other.orientation == orientation;

  @override
  int get hashCode => colors.hashCode* 31 + orientation.hashCode;

}

class QrColorRadialGradient extends QrColor {

  final List<Color> colors;
  final double radiusFraction;

  const QrColorRadialGradient({
    required this.colors,
    this.radiusFraction = 1
  });

  @override
  Paint createPaint(final double width, final double height) =>
      Paint()
        ..shader = Gradient.radial(
            Offset(width / 2, height / 2),
            min(width, height) * radiusFraction.coerceAtLeast(0),
            colors
        );

  @override
  bool operator ==(Object other) => other is QrColorRadialGradient &&
      other.colors == colors && other.radiusFraction == radiusFraction;

  @override
  int get hashCode => colors.hashCode* 31 + radiusFraction.hashCode;
}

class QrColorSweepGradient extends QrColor {

  final List<Color> colors;

  const QrColorSweepGradient({required this.colors});

  @override
  Paint createPaint(final double width, final double height) =>
      Paint()
        ..shader = Gradient.sweep(
            Offset(width / 2, height / 2),
            colors
        );

  @override
  bool operator ==(Object other) => other is QrColorSweepGradient &&
      other.colors == colors;

  @override
  int get hashCode => colors.hashCode;
}
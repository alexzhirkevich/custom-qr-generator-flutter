
import 'package:custom_qr_generator/shapes/shape.dart';

abstract class QrBallShape extends QrElementShape {

  const QrBallShape();

  static const basic = QrBallShapeDefault();

  static QrBallShapeCircle circle({double radiusFraction = 1}) =>
      QrBallShapeCircle(radiusFraction: radiusFraction);

  static QrBallShapeRoundCorners roundCorners({
    required double cornerFraction
  }) => QrBallShapeRoundCorners(cornerFraction: cornerFraction);
}

class QrBallShapeDefault extends QrBallShape with ShapeRect {
  const QrBallShapeDefault();

  @override
  bool operator ==(Object other) => other is QrBallShapeDefault;

  @override
  int get hashCode => 0;
}

class QrBallShapeCircle extends QrBallShape with ShapeCircle {

  @override
  final double radiusFraction;

  const QrBallShapeCircle({this.radiusFraction = 1});

  @override
  bool operator ==(Object other) => other is QrBallShapeCircle &&
    other.radiusFraction == radiusFraction;

  @override
  int get hashCode => radiusFraction.hashCode;

}

class QrBallShapeRoundCorners extends QrBallShape with ShapeRoundCorners {

  @override
  final double cornerFraction;

  const QrBallShapeRoundCorners({required this.cornerFraction});

  @override
  bool operator ==(Object other) => other is QrBallShapeRoundCorners &&
    other.cornerFraction == cornerFraction;

  @override
  int get hashCode => cornerFraction.hashCode;

}
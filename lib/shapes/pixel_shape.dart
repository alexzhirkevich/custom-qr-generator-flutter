
import 'package:custom_qr_generator/shapes/shape.dart';

abstract class QrPixelShape extends QrElementShape {

  const QrPixelShape();

  static const basic = QrPixelShapeDefault();

  static QrPixelShapeCircle circle({
    double radiusFraction = 1
  }) => QrPixelShapeCircle(radiusFraction: radiusFraction);

  static QrPixelShapeRoundCorners roundCorners({
    double cornerFraction = 1
  }) => QrPixelShapeRoundCorners(cornerFraction: cornerFraction);
}

class QrPixelShapeDefault extends QrPixelShape with ShapeRect {

    const QrPixelShapeDefault();

    @override
  bool operator ==(Object other) => other is QrPixelShapeDefault;

  @override
  int get hashCode => 0;
}

class QrPixelShapeCircle extends QrPixelShape with ShapeCircle {

    @override
    final double radiusFraction;

    const QrPixelShapeCircle({
        this.radiusFraction = 1.0
    });

    @override
  bool operator ==(Object other) => other is QrPixelShapeCircle &&
    other.radiusFraction == radiusFraction;

  @override
  int get hashCode => radiusFraction.hashCode;
}

class QrPixelShapeRoundCorners extends QrPixelShape with ShapeRoundCorners {

  @override
  final double cornerFraction;

  const QrPixelShapeRoundCorners({
    this.cornerFraction = .5
  });

  @override
  bool operator ==(Object other) =>
      other is QrPixelShapeRoundCorners &&
          other.cornerFraction == cornerFraction;

  @override
  int get hashCode => cornerFraction.hashCode;
}

import 'package:custom_qr_generator/shapes/shape.dart';

abstract class QrPixelShape  extends Shape {
    const QrPixelShape();
}

class QrPixelShapeDefault extends QrPixelShape with ShapeRect {

    const QrPixelShapeDefault();

    @override
    bool get dependOnNeighbors => false;

    @override
  bool operator ==(Object other) => other is QrPixelShapeDefault;

  @override
  int get hashCode => 0;
}

class QrPixelShapeCircle extends QrPixelShape with ShapeCircle {

    @override
    final double radiusFraction;

    @override
    bool get dependOnNeighbors => false;

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

    @override
    bool get dependOnNeighbors => true;

    const QrPixelShapeRoundCorners({
        this.cornerFraction = .5
    });

    @override
  bool operator ==(Object other) => other is QrPixelShapeRoundCorners &&
    other.cornerFraction == cornerFraction;

  @override
  int get hashCode => cornerFraction.hashCode;
}
import 'dart:ui';

import 'package:custom_qr_generator/custom_qr_generator.dart';

abstract class QrFrameShape extends QrElementShape {

  const QrFrameShape();

  static const basic = QrFrameShapeDefault();

  static QrFrameShapeCircle circle({
    double widthFraction = 1,
    double radiusFraction = 1
  }) => QrFrameShapeCircle(
          widthFraction: widthFraction,
          radiusFraction: radiusFraction
      );

  static QrFrameShapeRoundCorners roundCorners({
    required double cornerFraction,
    double widthFraction = 1,
    bool topLeft = true,
    bool topRight = true,
    bool bottomLeft = true,
    bool bottomRight = true
  }) => QrFrameShapeRoundCorners(
          widthFraction: widthFraction,
          cornerFraction: cornerFraction,
          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight
      );
}

class QrFrameShapeDefault extends QrFrameShape {

  const QrFrameShapeDefault();

  @override
  Path createPath(Offset offset, double size, Neighbors? neighbors) =>
      Path()
        ..fillType = PathFillType.evenOdd
        ..addRect(Rect.fromLTWH(offset.dx, offset.dy, size, size))
        ..addRect(Rect.fromLTWH(offset.dx +size / 7,offset.dy+ size / 7, size * 5 / 7, size * 5 / 7));


  @override
  bool operator ==(Object other) => other is QrFrameShapeDefault;

  @override
  int get hashCode => 0;
}

class QrFrameShapeCircle extends QrFrameShape {

  final double widthFraction;
  final double radiusFraction;

  const QrFrameShapeCircle({
    this.widthFraction = 1,
    this.radiusFraction = 1
  });

  @override
  Path createPath(Offset offset, double size, Neighbors? neighbors) {

    final realSize = size * radiusFraction;
    final offset2 = (size - realSize) / 2;
    final width = size / 7 * widthFraction.coerceAtLeast(0);


    return Path()
      ..fillType = PathFillType.evenOdd
      ..addOval(Rect.fromLTWH(offset.dx + offset2, offset.dy + offset2, realSize, realSize))
      ..addOval(Rect.fromLTWH(
          offset.dx + offset2 + width,
          offset.dy + offset2 + width,
          size - offset2 * 2 - width * 2,
          size - offset2 * 2 - width * 2
      ))
    ;
  }

  @override
  bool operator ==(Object other) => other is QrFrameShapeCircle &&
    other.widthFraction == widthFraction &&
    other.radiusFraction == radiusFraction;

  @override
  int get hashCode => (31 * widthFraction.hashCode) + radiusFraction.hashCode;

}

class QrFrameShapeRoundCorners extends QrFrameShape {

  final double cornerFraction;
  final double widthFraction;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  const QrFrameShapeRoundCorners({
    required this.cornerFraction,
    this.widthFraction = 1,
    this.topLeft = true,
    this.topRight = true,
    this.bottomLeft = true,
    this.bottomRight = true
  });

  @override
  Path createPath(Offset offset,double size, Neighbors? neighbors) {
    final cf = cornerFraction.coerceIn(0, .5);
    final cTopLeft = topLeft ? cf : 0;
    final cTopRight = topRight ? cf : 0;
    final cBottomLeft = bottomLeft ? cf : 0;
    final cBottomRight = bottomRight ? cf : 0;
    final w = size / 7 * widthFraction.coerceIn(0, 2);

    return Path()
      ..fillType=PathFillType.evenOdd
      ..addRRect(RRect.fromLTRBAndCorners(
        offset.dx, offset.dy,
        offset.dx + size, offset.dy + size,
        topLeft: Radius.circular(size * cTopLeft),
        topRight: Radius.circular(size * cTopRight),
        bottomLeft: Radius.circular(size * cBottomLeft),
        bottomRight: Radius.circular(size * cBottomRight),
      ))
      ..addRRect(RRect.fromLTRBAndCorners(
        offset.dx + w, offset.dy + w,
        offset.dx + size - w,  offset.dy + size - w,
        topLeft: Radius.circular((size - 2 * w) * cTopLeft),
        topRight: Radius.circular((size - 2 * w) * cTopRight),
        bottomLeft: Radius.circular((size - 2 * w) * cBottomLeft),
        bottomRight: Radius.circular((size - 2 * w) * cBottomRight),
      ));
  }

  @override
  bool operator ==(Object other) =>
      other is QrFrameShapeRoundCorners &&
          other.cornerFraction == cornerFraction &&
          other.widthFraction == widthFraction &&
          other.bottomRight == bottomRight &&
          other.bottomLeft == bottomLeft &&
          other.topLeft == topLeft &&
          other.topRight == topRight;

  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = hashCode * 31 + cornerFraction.hashCode;
    hashCode = hashCode * 31 + widthFraction.hashCode;
    hashCode = hashCode * 31 + bottomRight.hashCode;
    hashCode = hashCode * 31 + bottomLeft.hashCode;
    hashCode = hashCode * 31 + topLeft.hashCode;
    hashCode = hashCode * 31 + topRight.hashCode;
    return hashCode;
  }
}
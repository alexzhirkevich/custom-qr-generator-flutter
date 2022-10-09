import 'dart:ui';

import 'package:custom_qr_generator/custom_qr_generator.dart';
import 'package:custom_qr_generator/neighbors.dart';
import 'package:custom_qr_generator/util.dart';
import 'package:custom_qr_generator/shapes/shape.dart';

abstract class QrFrameShape extends Shape{
  @override
  bool get dependOnNeighbors => false;

  const QrFrameShape();
}

class QrFrameShapeDefault extends QrFrameShape {

  const QrFrameShapeDefault();

  @override
  Path createPath(double size, Neighbors? neighbors) {
    final big = Path()
      ..addRect(Rect.fromLTWH(0, 0, size, size));
    final small = Path()
      ..addRect(Rect.fromLTWH(size / 7, size / 7, size * 5 / 7, size * 5 / 7));

    return Path.combine(PathOperation.xor, big, small);
  }

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
  Path createPath(double size, Neighbors? neighbors) {
    final realSize = size * radiusFraction;
    final offset = (size - realSize) / 2;
    final width = size / 7 * widthFraction.coerceAtLeast(0);
    final big = Path()
      ..addOval(Rect.fromLTWH(offset, offset, realSize, realSize));

    final small = Path()
      ..addOval(Rect.fromLTWH(
          offset + width, offset + width,
          size - offset * 2 - width * 2, size - offset * 2 - width * 2
      ));

    return Path.combine(PathOperation.xor, small, big);
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
  Path createPath(double size, Neighbors? neighbors) {
    final cf = cornerFraction.coerceIn(0, .5);
    final cTopLeft = topLeft ? cf : 0;
    final cTopRight = topRight ? cf : 0;
    final cBottomLeft = bottomLeft ? cf : 0;
    final cBottomRight = bottomRight ? cf : 0;
    final w = size / 7 * widthFraction.coerceIn(0, 2);

    final big = Path()
      ..addRRect(RRect.fromLTRBAndCorners(0, 0, size, size,
        topLeft: Radius.circular(size * cTopLeft),
        topRight: Radius.circular(size * cTopRight),
        bottomLeft: Radius.circular(size * cBottomLeft),
        bottomRight: Radius.circular(size * cBottomRight),
      ));

    final small = Path()
      ..addRRect(RRect.fromLTRBAndCorners(w, w, size - w, size - w,
        topLeft: Radius.circular((size - 2 * w) * cTopLeft),
        topRight: Radius.circular((size - 2 * w) * cTopRight),
        bottomLeft: Radius.circular((size - 2 * w) * cBottomLeft),
        bottomRight: Radius.circular((size - 2 * w) * cBottomRight),
      ));

    return Path.combine(PathOperation.xor, big, small);
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
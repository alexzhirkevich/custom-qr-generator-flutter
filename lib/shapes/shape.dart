import 'dart:ui';

import 'package:custom_qr_generator/util.dart';

import '../../neighbors.dart';

abstract class QrElementShape {

  Path createPath(Offset offset, double size, Neighbors neighbors);

  const QrElementShape();
}

mixin ShapeRect implements QrElementShape {

  @override
  Path createPath(Offset offset, double size, Neighbors neighbors) => Path()
    ..addRect(Rect.fromLTWH(offset.dx, offset.dy, size, size));
}


mixin ShapeCircle implements QrElementShape {

  abstract final double radiusFraction;

  @override
  Path createPath(Offset offset, double size, Neighbors neighbors) {
    double cSizeFraction = radiusFraction.coerceIn(0.0, 1.0);
    double padding = size * (1 - cSizeFraction)/2;
    var sSize = size - 2*padding;
    return Path()
        ..addOval(Rect.fromLTWH(offset.dx + padding, offset.dy + padding,sSize, sSize));
  }
}

mixin ShapeRoundCorners implements QrElementShape {

    abstract final double cornerFraction;

    @override
    Path createPath(Offset offset, double size, Neighbors neighbors) {
      Path path = Path();
      double corner = cornerFraction.coerceIn(0, .5) * size;

      if (!neighbors.hasAny()){
        path.addRRect(RRect.fromLTRBR(
            offset.dx, offset.dy,
            offset.dx + size, offset.dy + size,
            Radius.circular(corner))
        );
      } else {

        double topLeft =0;
        double topRight=0;
        double bottomLeft=0;
        double bottomRight=0;

        if (!neighbors.top && !neighbors.left) {
          topLeft = corner;
        }
        if (!neighbors.top && !neighbors.right) {
          topRight = corner;
        }
        if (!neighbors.bottom && !neighbors.left) {
          bottomLeft = corner;
        }
        if (!neighbors.bottom && !neighbors.right) {
          bottomRight = corner;
        }

        path.addRRect(RRect.fromLTRBAndCorners(
          offset.dx, offset.dy, offset.dx + size, offset.dy + size,
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
        ));
      }

      return path;
    }
}
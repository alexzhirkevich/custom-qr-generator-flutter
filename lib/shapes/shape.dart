import 'dart:ui';

import 'package:custom_qr_generator/util.dart';

import '../../neighbors.dart';

abstract class Shape {

  abstract final bool dependOnNeighbors;

  Path createPath(double size, Neighbors? neighbors);

  const Shape();
}

mixin ShapeRect implements Shape {

  @override
  bool get dependOnNeighbors => false;

  @override
  Path createPath(double size, Neighbors? neighbors) => Path()
    ..addRect(Rect.fromLTRB(0, 0, size, size));
}


mixin ShapeCircle implements Shape {

  abstract final double radiusFraction;

  @override
  bool get dependOnNeighbors => false;

  @override
  Path createPath(double size, Neighbors? neighbors) {
    Path path = Path();
    double cSizeFraction = radiusFraction.coerceIn(0.0, 1.0);
    double padding = size * (1 - cSizeFraction)/2;
    path.addOval(Rect.fromLTRB(padding, padding, size- padding, size-padding));
    return path;
  }
}

mixin ShapeRoundCorners implements Shape {

    abstract final double cornerFraction;

    @override
    Path createPath(double size, Neighbors? neighbors) {
      Path path = Path();
      double corner = cornerFraction.coerceIn(0, .5) * size;


      if (!dependOnNeighbors || neighbors == null || !neighbors.hasAny()){
        path.addRRect(RRect.fromLTRBR(0, 0, size, size, Radius.circular(corner)));
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

        path.addRRect(RRect.fromLTRBAndCorners(0, 0, size, size,
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
        ));
      }

      return path;
    }
}
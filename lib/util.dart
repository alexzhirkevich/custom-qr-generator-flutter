
import 'package:zxing_lib/qrcode.dart';

import 'neighbors.dart';

extension DoubleEx on double{
  double coerceAtLeast(double from) {
    if (this < from) {
      return from;
    }
    return this;
  }
  double coerceAtMost(double to) {
    if (this > to) {
      return to;
    }
    return this;
  }
  double coerceIn(double from, double to) =>
        coerceAtLeast(from).coerceAtMost(to);
}

extension IntEx on int{
  inRange(int a, int b){
      return this >=a && this <=b;
  }
}


extension QrUtil on ByteMatrix {
  Neighbors neighbors(int x, int y) {
    final val = get(x, y);
    return Neighbors(
      topLeft: x > 0 && y > 0 && get(x-1, y-1) == val,
      top: y > 0 && get(x, y-1) == val,
      topRight: y > 0 && x < width-1 && get(x+1, y-1) == val,
      left:  x > 0 && get(x-1, y) == val,
      right: x < width - 1 && get(x+1, y) == val,
      bottomLeft: x > 0 && y < height-1 && get(x-1, y+1) == val,
      bottom: y < height -1 && get(x, y+1) == val,
      bottomRight: x < width - 1 && y < height -1 && get(x+1, y+1) == val
    );
  }
}
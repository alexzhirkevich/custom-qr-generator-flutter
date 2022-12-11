
class Neighbors {
  final bool topLeft;
  final bool topRight;
  final bool left;
  final bool top;
  final bool right;
  final bool bottomLeft;
  final bool bottom;
  final bool bottomRight;

  static const empty = Neighbors();

  const Neighbors({
    this.topLeft = false,
    this.topRight = false,
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottomLeft = false,
    this.bottom = false,
    this.bottomRight = false,
  });

  bool hasAny() {
    return topLeft || topRight || left || top ||
        right || bottomLeft || bottom || bottomRight;
  }

  bool hasAllNearest() {
    return top && bottom && left && right;
  }

  bool hasAll() {
    return topLeft && topRight && left && top &&
        right && bottomLeft && bottom && bottomRight;
  }

  @override
  bool operator ==(Object other) =>
      other is Neighbors &&
          other.topLeft == topLeft &&
          other.top == top &&
          other.topRight == topRight &&
          other.left == left &&
          other.right == right &&
          other.bottomLeft == bottomLeft &&
          other.bottomRight == bottomRight &&
          other.bottom == bottom;

  @override
  int get hashCode =>
      topLeft.hashCode + top.hashCode +
          topRight.hashCode + left.hashCode + right.hashCode +
          bottomLeft.hashCode + bottom.hashCode + bottomRight.hashCode;

}
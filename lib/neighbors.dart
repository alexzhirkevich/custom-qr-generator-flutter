
class Neighbors {
  bool topLeft;
  bool topRight;
  bool left;
  bool top;
  bool right;
  bool bottomLeft;
  bool bottom;
  bool bottomRight;

  Neighbors({
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

  bool hasAllNearest(){
    return top && bottom && left && right;
  }

  bool hasAll() {
    return topLeft && topRight && left && top &&
        right && bottomLeft && bottom && bottomRight;
  }
}
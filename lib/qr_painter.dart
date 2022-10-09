
import 'dart:math';

import 'package:custom_qr_generator/util.dart';
import 'package:custom_qr_generator/colors/color.dart';
import 'package:custom_qr_generator/options/options.dart';
import 'package:flutter/widgets.dart';
import 'package:zxing_lib/qrcode.dart';

class QrPainter extends CustomPainter {

  final String data;
  final QrOptions options;
  late ByteMatrix matrix;

  QrPainter({
    required this.data,
    required this.options
  }) {
    matrix = Encoder
        .encode(
        data, options.ecl, Map.fromEntries([
    ]))
        .matrix!;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final codeSize = min(size.width, size.height);
    final padding = codeSize * options.padding / 2;
    final pixelSize = (codeSize - 2 * padding) / matrix.width;
    final realCodeSize = codeSize - padding * 2;
    final lightPaint = options.colors.light.createPaint(
        realCodeSize, realCodeSize);
    final darkPaint = options.colors.dark.createPaint(
        realCodeSize, realCodeSize);
    Path? darkPath;
    Path? lightPath;
    Path fullDarkPath = Path();
    Path fullLightPath = Path();

    final framePath = options.shapes.frame.createPath(pixelSize * 7, null);
    final framePaint = options.colors.frame.createPaint(
        pixelSize * 3, pixelSize * 3);
    final ballPath = options.shapes.ball.createPath(pixelSize * 3, null);
    final ballPaint = options.colors.ball.createPaint(
        pixelSize * 3, pixelSize * 3);

    if (!options.shapes.darkPixel.dependOnNeighbors) {
      darkPath = options.shapes.darkPixel.createPath(pixelSize, null);
    }
    if (!options.shapes.lightPixel.dependOnNeighbors) {
      lightPath = options.shapes.lightPixel.createPath(pixelSize, null);
    }

    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        options.colors.background.createPaint(size.width, size.height)
    );

    canvas.save();
    canvas.translate(padding, padding);

    // todo: workaround for Dart bug with adding combined path.
    fullDarkPath = Path.combine(PathOperation.union, fullDarkPath, Path());

    if (options.colors.frame is! QrColorUnspecified) {
      canvas.drawPath(framePath, framePaint);
    } else {
      fullDarkPath.addPath(framePath, Offset.zero);
    }

    if (options.colors.ball is! QrColorUnspecified) {
      canvas.save();
      canvas.translate(pixelSize * 2, pixelSize * 2);
      canvas.drawPath(ballPath, ballPaint);
      canvas.restore();
    } else {
      fullDarkPath.addPath(ballPath, Offset(pixelSize * 2, pixelSize * 2));
    }

    canvas.save();
    canvas.translate(pixelSize * (matrix.width - 7), 0);
    if (options.colors.frame is! QrColorUnspecified) {
      canvas.drawPath(framePath, framePaint);
    } else {
      fullDarkPath.addPath(
          framePath, Offset(pixelSize * (matrix.width - 7), 0));
    }
    if (options.colors.ball is! QrColorUnspecified) {
      canvas.translate(pixelSize * 2, pixelSize * 2);
      canvas.drawPath(ballPath, ballPaint);
    } else {
      fullDarkPath.addPath(
          ballPath, Offset(pixelSize * (matrix.width - 5), pixelSize * 2));
    }
    canvas.restore();

    canvas.save();
    canvas.translate(0, pixelSize * (matrix.height - 7));
    if (options.colors.frame is! QrColorUnspecified) {
      canvas.drawPath(framePath, framePaint);
    } else {
      fullDarkPath.addPath(
          framePath, Offset(0, pixelSize * (matrix.width - 7)));
    }
    if (options.colors.ball is! QrColorUnspecified) {
      canvas.translate(pixelSize * 2, pixelSize * 2);
      canvas.drawPath(ballPath, ballPaint);
    } else {
      fullDarkPath.addPath(
          ballPath, Offset(pixelSize * 2, pixelSize * (matrix.height - 5)));
    }
    canvas.restore();


    for (int i = 0; i < matrix.width; i++) {
      for (int j = 0; j < matrix.height; j++) {
        if ((i.inRange(0, 6) && j.inRange(0, 6) ||
            i.inRange(matrix.width - 7, matrix.width - 1) && j.inRange(0, 6) ||
            j.inRange(matrix.height - 7, matrix.height - 1) && i.inRange(0, 6))
        ) {
          continue;
        }

        if (options.shapes.darkPixel.dependOnNeighbors) {
          darkPath = options.shapes.darkPixel.createPath(
              pixelSize, matrix.neighbors(i, j)
          );
        }
        if (options.shapes.lightPixel.dependOnNeighbors) {
          lightPath = options.shapes.lightPixel.createPath(
              pixelSize, matrix.neighbors(i, j)
          );
        }
        if (matrix.get(i, j) == 1) {
          fullDarkPath.addPath(darkPath!, Offset(i * pixelSize, j * pixelSize));
        }
        if (matrix.get(i, j) != 0) {
          fullLightPath.addPath(
              lightPath!, Offset(i * pixelSize, j * pixelSize));
        }
      }
    }
    canvas.drawPath(fullDarkPath, darkPaint);
    canvas.drawPath(fullLightPath, lightPaint);
    canvas.restore();
  }

  @override
  bool operator ==(Object other) =>
      other is QrPainter &&
          other.data == data && other.options == options;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  int get hashCode => (data.hashCode)*31 + options.hashCode;
}
# Custom QR generator for Flutter
[![pub package](https://img.shields.io/pub/v/custom_qr_generator.svg)](https://pub.dartlang.org/packages/custom_qr_generator)

<img src="https://raw.githubusercontent.com/alexzhirkevich/custom-qr-generator-flutter/master/img/screen1.png" width=200>

Flutter port of [Android library](https://github.com/alexzhirkevich/custom-qr-generator)

# Progress
- ✅ Vector codes
- ✅ Base and custom shapes
- ✅ Base and custom colors
- 🚧 Logo (Can be added just by placing your image on top of qr code image and inscreasing `errorCorrectionLevel`)

# Installing

## Depend on it


Run command

`$ flutter pub add custom_qr_generator`

This will add a line like this to your package's `pubspec.yaml` (and run an implicit `flutter pub get`):

```yaml
dependencies:
  custom_qr_generator: ^0.1.2
```

## Import it

Now in your Dart code, you can use:

```dart
import 'package:custom_qr_generator/custom_qr_generator.dart';
```

# Usage

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          child: CustomPaint(
            painter: QrPainter(
                data: "Welcome to Flutter",
                options: const QrOptions(
                    shapes: QrShapes(
                        darkPixel: QrPixelShapeRoundCorners(
                            cornerFraction: .5
                        ),
                        frame: QrFrameShapeRoundCorners(
                            cornerFraction: .25
                        ),
                        ball: QrBallShapeRoundCorners(
                            cornerFraction: .25
                        )
                    ),
                    colors: QrColors(
                        dark: QrColorLinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 0, 0),
                              Color.fromARGB(255, 0, 0, 255),
                            ],
                            orientation: GradientOrientation.leftDiagonal
                        )
                    )
                )),
            size: const Size(350, 350),
          ),
        ),
      ),
    );
  }
}

```

# Customization

You can implement custom shapes for any QR code parts: QrPixelShape, QrBallShape, QrFrameShape
like this:
```dart
class QrPixelShapeCircle extends QrPixelShape {
  
  @override
  Path createPath(double size, Neighbors neighbors) =>
      Path()..addOval(Rect.fromLTRB(0, 0, size, size));
}
```

Also you can create custom paint for this elements:

```dart

class QrColorRadialGradient extends QrColor {

  final List<Color> colors;

  const QrColorRadialGradient({
    required this.colors,
  });

  @override
  Paint createPaint(final double width, final double height) =>
      Paint()
        ..shader = Gradient.radial(
            Offset(width / 2, height / 2),
            min(width, height),
            colors
        );
}


```

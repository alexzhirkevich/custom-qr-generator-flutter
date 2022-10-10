# Custom QR generator for Flutter
[![pub package](https://img.shields.io/pub/v/custom_qr_generator.svg)](https://pub.dartlang.org/packages/custom_qr_generator)

Flutter port of [Android library](https://github.com/alexzhirkevich/custom-qr-generator)

# Progress
- ✅ Vector codes
- ✅ Base and custom shapes
- ✅ Base and custom colors
- 🚧 Logo

# Installing

## Depend on it


Run command

`$ flutter pub add custom_qr_generator`

This will add a line like this to your package's `pubspec.yaml` (and run an implicit `flutter pub get`):

```yaml
dependencies:
  custom_qr_generator: ^0.1.0
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
            size: const Size(300, 300),
          ),
        ),
      ),
    );
  }
}
```

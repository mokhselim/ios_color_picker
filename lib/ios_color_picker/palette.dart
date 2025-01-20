import 'package:flutter/material.dart';
import 'package:ios_color_picker/ios_color_picker/shared.dart';
import 'package:ios_color_picker/ios_color_picker/utils.dart';

class HSLWithSaturationColorPainter extends CustomPainter {
  const HSLWithSaturationColorPainter(this.hslColor, {this.pointerColor});

  final HSLColor hslColor;
  final Color? pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final List<Color> colors = [
      const HSLColor.fromAHSL(1.0, 0.0, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 60.0, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 120.0, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 180.0, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 240.0, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 300.0, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1.0, 360.0, 1, 0.5).toColor(),
    ];
    final Gradient gradientV = LinearGradient(
      colors: colors,
      // begin: Alignment.topCenter,
      // end: Alignment.bottomCenter,
    );
    const Gradient gradientH = LinearGradient(
      // begin: Alignment.centerLeft,
      // end: Alignment.centerRight,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.5, 0.5, 1],
      colors: [
        Colors.white,
        Color(0x00ffffff),
        Colors.transparent,
        Colors.black,
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));

    canvas.drawCircle(
      Offset(size.width * hslColor.hue / 360,
          size.height * (1 - hslColor.lightness)),
      size.height * 0.04,
      Paint()
        ..color = pointerColor ??
            (useWhiteForeground(hslColor.toColor())
                ? Colors.white
                : Colors.black)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ThumbPainter extends CustomPainter {
  const ThumbPainter({
    this.thumbColor,
    this.fullThumbColor = false,
    required this.small,
    required this.hsvColor,
  });

  final Color? thumbColor;
  final bool fullThumbColor;
  final bool small;
  final HSVColor hsvColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(
              center: const Offset(0.5, 2.0), radius: size.width * 1.8),
        ),
      Colors.black,
      3.0,
      true,
    );
    canvas.drawCircle(
        const Offset(8.0, 14 * 0.4),
        small ? 14 : 15.5,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill);
    if (!small) {
      canvas.drawCircle(
          const Offset(8.0, 14 * 0.4),
          13.5,
          Paint()
            ..color = hsvColor.toColor().withValues(alpha: 1)
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TrackPainter extends CustomPainter {
  const TrackPainter(
    this.trackType,
    this.hsvColor,
    this.small,
  );

  final TrackType trackType;
  final HSVColor hsvColor;
  final bool small;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    if (trackType == TrackType.alpha) {
      final Size chessSize = Size(size.height / 4, size.height / 4);
      Paint chessPaintB = Paint()..color = backgroundColor;
      Paint chessPaintW = Paint()..color = Colors.white;
      List.generate((size.height / chessSize.height).round(), (int y) {
        List.generate((size.width / chessSize.width).round(), (int x) {
          canvas.drawRect(
            Offset(chessSize.width * x, chessSize.width * y) & chessSize,
            (x + y) % 2 != 0 ? chessPaintW : chessPaintB,
          );
        });
      });
    }

    switch (trackType) {
      case TrackType.alpha:
        final List<Color> colors = [
          if (small) Colors.black.withValues(alpha: 0.8),
          if (small) Colors.transparent,
          hsvColor.toColor().withValues(alpha: 0.3),
          hsvColor.toColor().withValues(alpha: 1),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.hue:
        final List<Color> colors = [
          const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 60.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 180.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 240.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 300.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.saturation:
        final List<Color> colors = [
          HSVColor.fromAHSV(1.0, hsvColor.hue, 0.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.saturationForHSL:
        final List<Color> colors = [
          HSLColor.fromAHSL(1.0, hsvColor.hue, 0.0, 0.5).toColor(),
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 0.5).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.value:
        final List<Color> colors = [
          HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 0.0).toColor(),
          HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.lightness:
        final List<Color> colors = [
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 0.0).toColor(),
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 0.5).toColor(),
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.red:
        final List<Color> colors = [
          hsvColor.toColor().withRed(0).withValues(alpha: 1.0),
          hsvColor.toColor().withRed(255).withValues(alpha: 1.0),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.green:
        final List<Color> colors = [
          hsvColor.toColor().withGreen(0).withValues(alpha: 1.0),
          hsvColor.toColor().withGreen(255).withValues(alpha: 1.0),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.blue:
        final List<Color> colors = [
          hsvColor.toColor().withBlue(0).withValues(alpha: 1.0),
          hsvColor.toColor().withBlue(255).withValues(alpha: 1.0),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

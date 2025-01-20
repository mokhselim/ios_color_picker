import 'package:flutter/cupertino.dart';
import '../../palette.dart';
import '../../shared.dart';
import '../../utils.dart';

class ColorPickerSlider extends StatelessWidget {
  const ColorPickerSlider(
    this.trackType,
    this.hsvColor,
    this.onColorChanged, {
    super.key,
    this.displayThumbColor = false,
    this.fullThumbColor = false,
    this.small = true,
  });

  final TrackType trackType;
  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final bool displayThumbColor;
  final bool fullThumbColor;
  final bool small;

  void slideEvent(RenderBox getBox, BoxConstraints box, Offset globalPosition) {
    double localDx = getBox.globalToLocal(globalPosition).dx - 15.0;
    double progress =
        localDx.clamp(0.0, box.maxWidth - 30.0) / (box.maxWidth - 30.0);
    switch (trackType) {
      case TrackType.alpha:
        onColorChanged(hsvColor.withAlpha(
            localDx.clamp(0.0, box.maxWidth - 30.0) / (box.maxWidth - 30.0)));
        break;
      case TrackType.hue:
        onColorChanged(hsvColor.withHue(progress * 359));
        break;
      case TrackType.saturation:
        onColorChanged(hsvColor.withSaturation(progress));
        break;
      case TrackType.saturationForHSL:
        if (hslToHsv(hsvToHsl(hsvColor).withSaturation(progress)) != null) {
          onColorChanged(
              hslToHsv(hsvToHsl(hsvColor).withSaturation(progress))!);
        }
        break;
      case TrackType.value:
        onColorChanged(hsvColor.withValue(progress));
        break;
      case TrackType.lightness:
        if (hslToHsv(hsvToHsl(hsvColor).withLightness(progress)) != null) {
          onColorChanged(hslToHsv(hsvToHsl(hsvColor).withLightness(progress))!);
        }
        break;
      case TrackType.red:
        onColorChanged(HSVColor.fromColor(
            hsvColor.toColor().withRed((progress * 0xff).round())));
        break;
      case TrackType.green:
        onColorChanged(HSVColor.fromColor(
            hsvColor.toColor().withGreen((progress * 0xff).round())));
        break;
      case TrackType.blue:
        onColorChanged(HSVColor.fromColor(
            hsvColor.toColor().withBlue((progress * 0xff).round())));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints box) {
      double thumbOffset = small ? 0 : 15;
      Color thumbColor;
      _SliderLayout.small = small;
      switch (trackType) {
        case TrackType.hue:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.hue / 360;
          thumbColor = HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor();
          break;
        case TrackType.alpha:
          thumbOffset +=
              (box.maxWidth - (small ? 16.0 : 30)) * hsvColor.toColor().a;
          thumbColor = hsvColor.toColor().withValues(alpha: hsvColor.alpha);

          break;
        case TrackType.saturation:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.saturation;
          thumbColor =
              HSVColor.fromAHSV(1.0, hsvColor.hue, hsvColor.saturation, 1.0)
                  .toColor();
          break;
        case TrackType.saturationForHSL:
          thumbOffset += (box.maxWidth - 30.0) * hsvToHsl(hsvColor).saturation;
          thumbColor = HSLColor.fromAHSL(
                  1.0, hsvColor.hue, hsvToHsl(hsvColor).saturation, 0.5)
              .toColor();
          break;
        case TrackType.value:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.value;
          thumbColor = HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, hsvColor.value)
              .toColor();
          break;
        case TrackType.lightness:
          thumbOffset += (box.maxWidth - 30.0) * hsvToHsl(hsvColor).lightness;
          thumbColor = HSLColor.fromAHSL(
                  1.0, hsvColor.hue, 1.0, hsvToHsl(hsvColor).lightness)
              .toColor();
          break;
        case TrackType.red:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.toColor().red / 0xff;
          thumbColor = hsvColor.toColor().withValues(alpha: 1.0);
          break;
        case TrackType.green:
          thumbOffset +=
              (box.maxWidth - 30.0) * hsvColor.toColor().green / 0xff;
          thumbColor = hsvColor.toColor().withValues(alpha: 1.0);
          break;
        case TrackType.blue:
          thumbOffset += (box.maxWidth - 30.0) * hsvColor.toColor().blue / 0xff;
          thumbColor = hsvColor.toColor().withValues(alpha: 1.0);
          break;
      }

      return CustomMultiChildLayout(
        delegate: _SliderLayout(),
        children: [
          LayoutId(
            id: _SliderLayout.track,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              child: CustomPaint(
                  painter: TrackPainter(
                trackType,
                hsvColor,
                small,
              )),
            ),
          ),
          LayoutId(
            id: _SliderLayout.thumb,
            child: Transform.translate(
              offset: Offset(thumbOffset, 0.0),
              child: CustomPaint(
                painter: ThumbPainter(
                    thumbColor: displayThumbColor ? thumbColor : null,
                    fullThumbColor: fullThumbColor,
                    hsvColor: hsvColor,
                    small: small),
              ),
            ),
          ),
          LayoutId(
            id: _SliderLayout.gestureContainer,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints box) {
                RenderBox? getBox = context.findRenderObject() as RenderBox?;
                return GestureDetector(
                  onPanDown: (DragDownDetails details) => getBox != null
                      ? slideEvent(getBox, box, details.globalPosition)
                      : null,
                  onPanUpdate: (DragUpdateDetails details) => getBox != null
                      ? slideEvent(getBox, box, details.globalPosition)
                      : null,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class _SliderLayout extends MultiChildLayoutDelegate {
  static const String track = 'track';
  static const String thumb = 'thumb';
  static bool small = true;
  static const String gestureContainer = 'gesturecontainer';

  @override
  void performLayout(Size size) {
    layoutChild(
      track,
      BoxConstraints.tightFor(
        width: size.width + (small ? 0 : 6),
        height: small ? 20 : 36,
      ),
    );
    positionChild(track, Offset(small ? 0.0 : 5, 0));
    layoutChild(
      thumb,
      BoxConstraints.tightFor(
        width: 5.0,
        height: small ? 20 : 36,
      ),
    );
    positionChild(thumb, Offset(0.0, (small ? 5 : 12)));
    layoutChild(
      gestureContainer,
      BoxConstraints.tightFor(width: size.width, height: size.height),
    );
    positionChild(gestureContainer, Offset.zero);
  }

  @override
  bool shouldRelayout(_SliderLayout oldDelegate) => false;
}

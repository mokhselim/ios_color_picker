import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import '../palette.dart';
import '../shared.dart';
import '../utils.dart';

class AreaColorPicker extends StatefulWidget {
  const AreaColorPicker({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
    this.pickerHsvColor,
    this.onHsvColorChanged,
    this.paletteType = ColorsType.hsvWithHue,
    this.displayThumbColor = false,
    this.portraitOnly = false,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final HSVColor? pickerHsvColor;
  final ValueChanged<HSVColor>? onHsvColorChanged;
  final ColorsType paletteType;
  final bool displayThumbColor;
  final bool portraitOnly;

  @override
  State<AreaColorPicker> createState() => _AreaColorPickerState();
}

class _AreaColorPickerState extends State<AreaColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);
  List<Color> colorHistory = [];

  @override
  void initState() {
    currentHsvColor = (widget.pickerHsvColor != null)
        ? widget.pickerHsvColor as HSVColor
        : HSVColor.fromColor(widget.pickerColor);

    super.initState();
  }

  @override
  void didUpdateWidget(AreaColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = (widget.pickerHsvColor != null)
        ? widget.pickerHsvColor as HSVColor
        : HSVColor.fromColor(widget.pickerColor);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onColorChanging(HSVColor color) {
    setState(() => currentHsvColor = color);
    widget.onColorChanged(currentHsvColor.toColor());
    if (widget.onHsvColorChanged != null) {
      widget.onHsvColorChanged!(currentHsvColor);
    }
  }

  Widget colorPicker() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child:
          ColorPickerArea(currentHsvColor, onColorChanging, widget.paletteType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16,
            top: 16,
          ),
          child: SizedBox(
            width: double.infinity,
            height: componentsHeight(context),
            child: colorPicker(),
          ),
        ),
        const SizedBox(height: 17.0),
      ],
    );
  }
}

class ColorPickerArea extends StatelessWidget {
  const ColorPickerArea(
    this.hsvColor,
    this.onColorChanged,
    this.paletteType, {
    super.key,
  });

  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final ColorsType paletteType;

  void _handleColorRectChange(double horizontal, double vertical) {
    switch (paletteType) {
      case ColorsType.hslWithSaturation:
        if (hslToHsv(
              hsvToHsl(hsvColor)
                  .withHue(horizontal * 360)
                  .withLightness(vertical),
            ) !=
            null) {
          onColorChanged(hslToHsv(
            hsvToHsl(hsvColor)
                .withHue(horizontal * 360)
                .withLightness(vertical),
          )!);
        }
        break;

      default:
        break;
    }
  }

  void _handleGesture(
      Offset position, BuildContext context, double height, double width) {
    RenderBox? getBox = context.findRenderObject() as RenderBox?;
    if (getBox == null) return;
    Offset localOffset = getBox.globalToLocal(position);
    double horizontal = localOffset.dx.clamp(0.0, width);
    double vertical = localOffset.dy.clamp(0.0, height);
    _handleColorRectChange(horizontal / width, 1 - vertical / height);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        return RawGestureDetector(
          gestures: {
            _AlwaysWinPanGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                    _AlwaysWinPanGestureRecognizer>(
              () => _AlwaysWinPanGestureRecognizer(),
              (_AlwaysWinPanGestureRecognizer instance) {
                instance
                  ..onDown = ((details) => _handleGesture(
                      details.globalPosition, context, height, width))
                  ..onUpdate = ((details) => _handleGesture(
                      details.globalPosition, context, height, width));
              },
            ),
          },
          child: Builder(
            builder: (BuildContext _) {
              switch (paletteType) {
                case ColorsType.hslWithSaturation:
                  return CustomPaint(
                      painter:
                          HSLWithSaturationColorPainter(hsvToHsl(hsvColor)));

                default:
                  return const CustomPaint();
              }
            },
          ),
        );
      },
    );
  }
}

class _AlwaysWinPanGestureRecognizer extends PanGestureRecognizer {
  @override
  void addAllowedPointer(event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }

  @override
  String get debugDescription => 'alwaysWin';
}

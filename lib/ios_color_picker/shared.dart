import 'package:flutter/cupertino.dart';

///Pickers Components height
double componentsHeight(BuildContext context) {
  return (maxWidth(context) - 32) - (((maxWidth(context) - 32) / 12) * 2);
}

double maxWidth(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width > 400) {
    width = 400;
  }
  return width;
}

enum ColorsType {
  hsvWithHue,
  hslWithSaturation,
}

const Color backgroundColor = Color(0xff232421);
const Color valueColor = Color(0xff1C1C1E);
const Color sliderColor = Color(0xff38393B);
const Color selectedSliderColor = Color(0xff6F6F73);

enum TrackType {
  hue,
  alpha,
  saturation,
  saturationForHSL,
  value,
  lightness,
  red,
  green,
  blue,
}

enum ColorLabelType { hex, rgb, hsv, hsl }

enum ColorModel { rgb, hsv, hsl }

///hexValidator
const String kCompleteValidHexPattern =
    r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$';

///
const defaultHistoryColors = [
  Color(0xff0061FD),
  Color(0xff982ABC),
  Color(0xffB92D5D),
  Color(0xffFF6A00),
  Color(0xffFFAB01),
  Color(0xffFEFB41),
  Color(0xff76BB40),
];

///Colors List for Grid section Picker
const List<Color> colors = [
  Color(0xffFEFFFE),
  Color(0xffEBEBEB),
  Color(0xffD6D6D6),
  Color(0xffC2C2C2),
  Color(0xffADADAD),
  Color(0xff999999),
  Color(0xff858585),
  Color(0xff707070),
  Color(0xff5C5C5C),
  Color(0xff474747),
  Color(0xff333333),
  Color(0xff000000),
  //1
  Color(0xff00374A),
  Color(0xff011D57),
  Color(0xff11053B),
  Color(0xff2E063D),
  Color(0xff3C071B),
  Color(0xff5C0701),
  Color(0xff5A1C00),
  Color(0xff583300),
  Color(0xff563D00),
  Color(0xff666100),
  Color(0xff4F5504),
  Color(0xff263E0F),
  //2
  Color(0xff004D65),
  Color(0xff012F7B),
  Color(0xff1A0A52),
  Color(0xff450D59),
  Color(0xff551029),
  Color(0xff831100),
  Color(0xff7B2900),
  Color(0xff7A4A00),
  Color(0xff785800),
  Color(0xff8D8602),
  Color(0xff6F760A),
  Color(0xff38571A),
  //3
  Color(0xff016E8F),
  Color(0xff0042A9),
  Color(0xff2C0977),
  Color(0xff61187C),
  Color(0xff791A3D),
  Color(0xffB51A00),
  Color(0xffAD3E00),
  Color(0xffA96800),
  Color(0xffA67B01),
  Color(0xffC4BC00),
  Color(0xff9BA50E),
  Color(0xff4E7A27),
  //4
  Color(0xff008CB4),
  Color(0xff0056D6),
  Color(0xff371A94),
  Color(0xff7A219E),
  Color(0xff99244F),
  Color(0xffE22400),
  Color(0xffDA5100),
  Color(0xffD38301),
  Color(0xffD19D01),
  Color(0xffF5EC00),
  Color(0xffC3D117),
  Color(0xff669D34),
  //5
  Color(0xff00A1D8),
  Color(0xff0061FD),
  Color(0xff4D22B2),
  Color(0xff982ABC),
  Color(0xffB92D5D),
  Color(0xffFF4015),
  Color(0xffFF6A00),
  Color(0xffFFAB01),
  Color(0xffFCC700),
  Color(0xffFEFB41),
  Color(0xffD9EC37),
  Color(0xff76BB40),
  //6
  Color(0xff01C7FC),
  Color(0xff3A87FD),
  Color(0xff5E30EB),
  Color(0xffBE38F3),
  Color(0xffE63B7A),
  Color(0xffFE6250),
  Color(0xffFE8648),
  Color(0xffFEB43F),
  Color(0xffFECB3E),
  Color(0xffFFF76B),
  Color(0xffE4EF65),
  Color(0xff96D35F),
  //7
  Color(0xff52D6FC),
  Color(0xff74A7FF),
  Color(0xff864FFD),
  Color(0xffD357FE),
  Color(0xffEE719E),
  Color(0xffFF8C82),
  Color(0xffFEA57D),
  Color(0xffFEC777),
  Color(0xffFED977),
  Color(0xffFFF994),
  Color(0xffEAF28F),
  Color(0xffB1DD8B),
  //8
  Color(0xff93E3FC),
  Color(0xffA7C6FF),
  Color(0xffB18CFE),
  Color(0xffE292FE),
  Color(0xffF4A4C0),
  Color(0xffFFB5AF),
  Color(0xffFFC5AB),
  Color(0xffFED9A8),
  Color(0xffFDE4A8),
  Color(0xffFFFBB9),
  Color(0xffF1F7B7),
  Color(0xffCDE8B5),
  //9
  Color(0xffCBF0FF),
  Color(0xffD2E2FE),
  Color(0xffD8C9FE),
  Color(0xffEFCAFE),
  Color(0xffF9D3E0),
  Color(0xffFFDAD8),
  Color(0xffFFE2D6),
  Color(0xffFEECD4),
  Color(0xffFEF1D5),
  Color(0xffFDFBDD),
  Color(0xffF6FADB),
  Color(0xffDEEED4),
];

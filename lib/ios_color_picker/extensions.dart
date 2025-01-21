import 'dart:ui';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = false}) =>
      '${leadingHashSign ? '#' : ''}'
      // '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${r.toInt().toRadixString(16).padLeft(2, '0')}'
      '${g.toInt().toRadixString(16).padLeft(2, '0')}'
      '${b.toInt().toRadixString(16).padLeft(2, '0')}';
}

extension ListColorConverter on List<Color> {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static List<Color> fromStringColors(List<String> colorsString) {
    List<Color> converted = [];
    for (var item in colorsString) {
      converted.add(HexColor.fromHex(item));
    }
    return converted;
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  List<String> toStringList() {
    List<String> converted = [];
    forEach((item) {
      String value = '';
      value = item.toHex().replaceFirst('Color(', '');
      value = value.toString().replaceFirst('Color', '');
      value = value.replaceFirst(')', '');
      value = value.replaceFirst('(', '');
      if (value.contains("0xff")) {
        value = value.replaceFirst('0xff', '');
      } else if (value.length > 7) {
        value = value.substring(4, value.length);
      }
      converted.add(value);
    });
    return converted;
  }
}

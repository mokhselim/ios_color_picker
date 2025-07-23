import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ios_color_picker/custom_picker/extensions.dart';
import 'ios_color_picker_platform_interface.dart';

/// An implementation of [IosColorPickerV2Platform] that uses method channels.
class MethodChannelIosColorPicker extends IosColorPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_color_picker');

  @override
  Future<Color?> getPlatformColor(
      Map<String, double>? defaultColor, bool? darkMode) async {
    Map<String, dynamic> map = {};
    map.addAll(darkMode != null ? {"darkMode": darkMode} : {});
    map.addAll(defaultColor != null ? {"defaultColor": defaultColor} : {});
    final color = await methodChannel.invokeMethod<Map>(
      'pickColor',
      map,
    );
    if (color == null) {
      return null;
    }
    debugPrint(color.toString());
    log(color.toString());
    log("MOOOOOO");
    return Map<String, double>.from(color).toColor();
  }
}

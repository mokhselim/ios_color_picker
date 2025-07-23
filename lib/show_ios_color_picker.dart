import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_picker/color_observer.dart';
import 'custom_picker/ios_color_picker.dart';
import 'custom_picker/extensions.dart';
import 'native_picker/ios_color_picker_platform_interface.dart';

///Don't forget to Dispose the controller
///
///because the streamer, check the example in example/ folder
class IOSColorPickerController {
  Color selectedColor = Colors.green;
  static const _eventChannel = EventChannel('ios_color_picker_stream');
  StreamSubscription? _colorSubscription;

  /// iOS Native color Picker, Only for iOS.
  ///
  /// If [darkMode] is [null], then the color will depend on device system
  /// [startingColor] is [null] then the default color will be green
  Future<void> showNativeIosColorPicker({
    required ValueChanged<Color> onColorChanged,
    Color? startingColor,
    bool? darkMode,
  }) async {
    assert(Platform.isIOS,
        "Only works for iOS use (showIOSCustomColorPicker) for other platforms");

    selectedColor = startingColor ?? selectedColor;

    IosColorPickerPlatform.instance
        .getPlatformColor(selectedColor.toMap(), darkMode);
    _colorSubscription = _eventChannel.receiveBroadcastStream().listen((event) {
      debugPrint(event.toString());
      log(event.toString());
      debugPrint("MOOOOOO");
      if (event != null) {
        try {
          selectedColor = (event as Map<Object?, Object?>).toColor();
        } catch (error) {
          rethrow;
        }

        onColorChanged(selectedColor);
      }
    }, onError: (err) {
      throw err;
    });
  }

  /// iOS Native color Picker clone, for all Platforms.
  ///
  /// [startingColor] is [null] then the default color will be green
  void showIOSCustomColorPicker({
    required BuildContext context,
    required ValueChanged<Color> onColorChanged,
    Color? startingColor,
  }) async {
    colorController = ColorController(startingColor ?? selectedColor);
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black26,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return IosColorPicker(
            onColorSelected: (value) {
              selectedColor = value;
              onColorChanged(selectedColor);
            },
          );
        });
  }

  /// Cancel the color subscription
  void cancelColorSubscription() {
    if (_colorSubscription != null) {
      _colorSubscription!.cancel();
      _colorSubscription = null;
    }
  }

  /// Dispose resources
  void dispose() {
    cancelColorSubscription();
  }
}

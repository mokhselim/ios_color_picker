import Flutter
import UIKit


public class IosColorPickerPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var eventSink: FlutterEventSink? // EventSink for streaming data

    public static func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(name: "ios_color_picker", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "ios_color_picker_stream", binaryMessenger: registrar.messenger())

        let instance = IosColorPickerPlugin()
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        eventChannel.setStreamHandler(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "pickColor":
            if let args = call.arguments as? [String: Any]
                {
                let defaultColor = args["defaultColor"] as? [String: CGFloat]
                let darkMode = args["darkMode"] as? Bool ?? false
                self.pickColor(defaultColor: defaultColor, darkMode: darkMode ,result: result)
            } else {
                self.pickColor(defaultColor: nil, darkMode: false, result: result)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func pickColor(defaultColor: [String: CGFloat]?, darkMode: Bool, result: @escaping FlutterResult) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = defaultColor?.toUIColor() ?? .red
        colorPicker.modalPresentationStyle = .popover
        if darkMode {
                UIApplication.shared.delegate?.window??.overrideUserInterfaceStyle = .dark

        }

        colorPicker.delegate = self

        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            rootViewController.present(colorPicker, animated: true, completion: nil)
        }

        result(nil)
    }

    // MARK: - FlutterStreamHandler

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}

// MARK: - UIColorPickerViewControllerDelegate

extension IosColorPickerPlugin: UIColorPickerViewControllerDelegate {
    public func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor) {
       if let rgba = viewController.selectedColor.toRGBA(), let eventSink = self.eventSink {
           eventSink(rgba)
       }
    }

       public func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
                if let rgba = viewController.selectedColor.toRGBA(), let eventSink = self.eventSink {
                    eventSink(rgba)
                }
            }
}

extension UIColor {
    func toRGBA() -> [String: CGFloat]? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        return [
            "red": red ,
            "green": green ,
            "blue": blue ,
            "alpha": alpha
        ]
    }
}

extension Dictionary where Key == String, Value == CGFloat {
    func toUIColor() -> UIColor {
        let red = self["red"] ?? 0
        let green = self["green"] ?? 0
        let blue = self["blue"] ?? 0
        let alpha = self["alpha"] ?? 1

        return UIColor(
            red: red ,
            green: green ,
            blue: blue ,
            alpha: alpha
        )
    }
}

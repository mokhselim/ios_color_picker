import Flutter
import UIKit


public class IosColorPickerPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?

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
            let args = call.arguments as? [String: Any]
            let defaultColor = args?["defaultColor"] as? [String: Any]
            let darkMode = args?["darkMode"] as? Bool
            self.pickColor(defaultColor: defaultColor, darkMode: darkMode, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func pickColor(defaultColor: [String: Any]?, darkMode: Bool?, result: @escaping FlutterResult) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = defaultColor?.toUIColor() ?? .red
        colorPicker.modalPresentationStyle = .popover
        if let darkMode {
            colorPicker.overrideUserInterfaceStyle = darkMode ? .dark : .light
        }

        colorPicker.delegate = self

        if let rootViewController = Self.rootViewController() {
            rootViewController.present(colorPicker, animated: true, completion: nil)
            result(nil)
        } else {
            result(FlutterError(
                code: "NO_ROOT_VIEW_CONTROLLER",
                message: "Unable to present the iOS color picker.",
                details: nil
            ))
        }
    }

    private static func rootViewController() -> UIViewController? {
        guard let root = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?
            .rootViewController else {
            return nil
        }

        var topController = root
        while let presented = topController.presentedViewController {
            topController = presented
        }
        return topController
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

extension Dictionary where Key == String, Value == Any {
    private func cgFloat(for key: String, fallback: CGFloat) -> CGFloat {
        if let value = self[key] as? CGFloat {
            return value
        }
        if let value = self[key] as? Double {
            return CGFloat(value)
        }
        if let value = self[key] as? NSNumber {
            return CGFloat(truncating: value)
        }
        return fallback
    }

    func toUIColor() -> UIColor {
        let red = cgFloat(for: "red", fallback: 0)
        let green = cgFloat(for: "green", fallback: 0)
        let blue = cgFloat(for: "blue", fallback: 0)
        let alpha = cgFloat(for: "alpha", fallback: 1)

        return UIColor(
            red: red ,
            green: green ,
            blue: blue ,
            alpha: alpha
        )
    }
}

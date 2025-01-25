import Flutter
import UIKit

public class SwiftIosColorPickerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ios_color_picker", binaryMessenger: registrar.messenger())
        let instance = SwiftIosColorPickerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "pickColor" {
            self.pickColor(result: result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

   private func pickColor(result: @escaping FlutterResult) {
       let colorPicker = UIColorPickerViewController()
       colorPicker.selectedColor = .red // Default color
       colorPicker.delegate = self

       // Present the color picker
       if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
           rootViewController.present(colorPicker, animated: true, completion: nil)
       }
   }
}

extension SwiftIosColorPickerPlugin: UIColorPickerViewControllerDelegate {
    public func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        // Send the color back to Flutter
        result(["red": Int(color.redValue * 255), "green": Int(color.greenValue * 255), "blue": Int(color.blueValue * 255)])
    }
}

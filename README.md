<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
## Description
Animated collapsible sidebar for Flutter apps " macOS & Web & Windows & Linux " with very cool animation and responsive with full control to customize the colors and texts and almost everything

# This package supports all platforms listed below.

### **platforms:**

* linux
* macos
* web
* windows
* iOS
* Android


## Features
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504135/color_picker/1_v2nk8m.png">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504147/color_picker/2_sp5wvu.png">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504137/color_picker/3_ovqzg6.png">


<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504183/color_picker/1_p91sih.gif">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504147/color_picker/2_sp5wvu.png">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504212/color_picker/3_zkbdzu.gif">





[//]: # (## Getting started)


[//]: # (start using the package.)

## Usage


[//]: # (to `/example` folder.)

```dart

ElevatedButton(
onPressed: () {
showModalBottomSheet(
backgroundColor: Colors.transparent,
barrierColor: Colors.transparent,
isScrollControlled: true,
context: context,
  builder: (context) {
        return IosColorPicker(
        onColorSelected: (Color value) {
          setState(() {
            backgroundColor = value;
          });
          },);
          });
            },
    child: Text("SelectColor"),
),

```

## 🧪 Example

Please run the app in the [`example/`](https://github.com/mokhselim/ios_color_picker/tree/main/example) folder to start playing!

## Additional information
<a href="https://www.linkedin.com/in/mo-kh-selim/"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/LinkedIn_icon.svg/144px-LinkedIn_icon.svg.png" /></a>


# ios_color_picker

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
<img src="https://github.com/mokhselim/ios_color_picker/blob/main/example/assets/1.png">
<img src="https://github.com/mokhselim/ios_color_picker/blob/main/example/assets/2.png">
<img src="https://github.com/mokhselim/ios_color_picker/blob/main/example/assets/3.png">


<img src="https://github.com/mokhselim/ios_color_picker/blob/main/example/assets/1.gif">
<img src="https://github.com/mokhselim/ios_color_picker/blob/main/example/assets/2.gif">
<img src="https://github.com/mokhselim/ios_color_picker/blob/main/example/assets/3.gif">





[//]: # (## Getting started)


[//]: # (start using the package.)

## Usage


[//]: (to `/example` folder.)

~~~~dart

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
},
);
});
},
child: Text("SelectColor"),
),
~~~~

## Additional information
LinkedIn
<link as="https://www.linkedin.com/in/mo-kh-selim/">



# ios_color_picker

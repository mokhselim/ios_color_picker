import 'package:flutter/material.dart';
import 'package:ios_color_picker/ios_color_picker/extensions.dart';
import '../ios_color_picker.dart';
import '../shared.dart';

class GridPicker extends StatelessWidget {
  const GridPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: componentsHeight(context),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        17,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: colors.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 12),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => colorController.updateColor(colors[index]),
            child: Container(
              padding: EdgeInsets.all(
                  colorController.value.toHex() == colors[index].toHex()
                      ? 3
                      : 0),
              decoration: BoxDecoration(
                color: index == 0 ? Color(0xff999999) : Colors.white,
              ),
              child: ClipRRect(
                borderRadius: index == 0
                    ? BorderRadius.only(topLeft: Radius.circular(6))
                    : index == 11
                        ? BorderRadius.only(topRight: Radius.circular(6))
                        : index == colors.length - 1
                            ? BorderRadius.only(bottomRight: Radius.circular(6))
                            : index == colors.length - 12
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(6))
                                : BorderRadius.zero,
                child: ColoredBox(
                  color: colors[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

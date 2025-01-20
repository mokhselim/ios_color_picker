import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ios_color_picker/ios_color_picker/extensions.dart';
import 'package:ios_color_picker/ios_color_picker/shared.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'helpers/cache_helper.dart';
import 'ios_color_picker.dart';

class HistoryColors extends StatefulWidget {
  const HistoryColors({super.key});

  @override
  State<HistoryColors> createState() => _HistoryColorsState();
}

class _HistoryColorsState extends State<HistoryColors> {
  int page = 0;
  int colorPage = 0;
  int toolTip = 0;
  PageController pageController = PageController();
  final _tipController = SuperTooltipController();

  List<Color> historyColors = [];

  @override
  void initState() {
    List<dynamic> savedColors =
        CacheHelper().getData(key: "history_colors") ?? [];
    if (savedColors.isEmpty) {
      historyColors = defaultHistoryColors;
      setHistory();
    } else {
      for (var value in savedColors) {
        historyColors.add(HexColor.fromHex(value.toString()));
      }
      setHistory(empty: false);
    }
    super.initState();
  }

  void setHistory({bool empty = true, bool delete = false}) {
    page = 0;
    for (int i = 0; i < historyColors.length + 1; i++) {
      if (i % 10 == 0) {
        page++;
      }
    }
    if (empty) {
      historyColors.toStringList().forEach((v) {});
      CacheHelper()
          .setData(key: "history_colors", value: historyColors.toStringList());
      if (page > 1 && colorPage != page && !delete) {
        pageController.jumpToPage(page);
        colorPage = page;
      }
    } else {
      if (!delete) {
        Future.delayed(const Duration(milliseconds: 200)).then((v) {
          pageController.jumpToPage(page);
        });
      }
    }
    if (delete) {
      _tipController.hideTooltip();
    }
  }

  Future<void> showTooltip() async {
    _tipController.hideTooltip();
    await Future.delayed(const Duration(milliseconds: 200));
    _tipController.showTooltip();
  }

  @override
  void dispose() {
    pageController.dispose();
    _tipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 97,
      width: MediaQuery.sizeOf(context).width - 120,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (v) {
                setState(() {
                  colorPage = v;
                });
              },
              children: List.generate(page, (pageIndex) {
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 27, right: 17),
                  crossAxisCount: 5,
                  mainAxisSpacing: 12,
                  crossAxisSpacing:
                      ((MediaQuery.sizeOf(context).width - 304) / 5),
                  dragStartBehavior: DragStartBehavior.down,
                  children: List.generate(
                      historyColors.length >= 10
                          ? (historyColors.length - (pageIndex * 10)) + 1
                          : historyColors.length + 1, (index) {
                    if (index + (pageIndex * 10) == historyColors.length) {
                      return InkWell(
                        onTap: () {
                          historyColors.add(colorController.value);
                          setHistory();
                        },
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              minHeight: 30,
                              minWidth: 30,
                              maxWidth: 30,
                              maxHeight: 30),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.16),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xffB0B0BD),
                            ),
                          ),
                        ),
                      );
                    }
                    return SuperTooltip(
                      onHide: () {
                        toolTip = -1;
                      },
                      onLongPress: () {
                        setState(() {
                          toolTip = (index + (pageIndex * 10));
                        });
                        showTooltip();
                      },
                      showBarrier: false,
                      // showDropBoxFilter: true,
                      hasShadow: false,
                      sigmaY: 16,
                      sigmaX: 16,
                      arrowLength: 8,
                      arrowTipDistance: 17,
                      bubbleDimensions: EdgeInsets.zero,
                      popupDirection: TooltipDirection.up,
                      controller: toolTip == (index + (pageIndex * 10))
                          ? _tipController
                          : null,
                      content: InkWell(
                        onTap: () {
                          historyColors.removeAt((index + (pageIndex * 10)));
                          setHistory(delete: true);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Text(
                            "Delete",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          colorController.updateColor(
                              historyColors[(index + (pageIndex * 10))]);
                          _tipController.hideTooltip();
                          toolTip = -1;
                          setState(() {});
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minHeight: 30,
                                  minWidth: 30,
                                  maxWidth: 30,
                                  maxHeight: 30),
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      historyColors[(index + (pageIndex * 10))],
                                ),
                              ),
                            ),
                            if (colorController.value.toHex() ==
                                historyColors[(index + (pageIndex * 10))]
                                    .toHex())
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
          if (page > 1)
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: AnimatedSmoothIndicator(
                activeIndex: colorPage,
                count: page,
                effect: ScrollingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  maxVisibleDots: 11,
                  spacing: 10,
                  // verticalOffset: 18,
                  dotColor: Colors.white.withValues(alpha: 0.3),
                  activeDotColor: Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }
}

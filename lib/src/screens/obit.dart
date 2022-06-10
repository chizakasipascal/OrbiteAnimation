import 'package:flutter/material.dart';
import 'package:obiteanimation/src/utils/app_theme.dart';
import 'package:obiteanimation/src/widgets/obitAnimation.dart';

class Orbit extends StatefulWidget {
  @override
  _Orbit createState() => _Orbit();
}

////
///
/// Model class
class Content {
  final num;
  final IconData icon;

  Content(this.num, this.icon);
}

///
///
///

class _Orbit extends State<Orbit> with TickerProviderStateMixin {
  late AnimationController controllerx, controllerx2;
  late AnimationController controllery, controllery2;
  bool showEffectRotation = false;
  bool showEffectRotationLongPresse = false;
  double posx = 100.0;
  double posy = 100.0;
  @override
  void initState() {
    super.initState();
    controllerx = AnimationController(vsync: this);
    controllery = AnimationController(vsync: this);
    controllerx2 = AnimationController(vsync: this);
    controllery2 = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controllerx.dispose();
    controllery.dispose();
    super.dispose();
  }

  void startRotation(int durationx, int durationy) {
    controllerx.repeat(
        min: 0.0,
        max: 1.0,
        period:
            Duration(seconds: showEffectRotationLongPresse ? 2 : durationx));
    controllery.repeat(
        min: 0.0,
        max: 1.0,
        period:
            Duration(seconds: showEffectRotationLongPresse ? 2 : durationy));

    setState(() {
      showEffectRotation = true;
    });
  }

  void startRotationEffectLongPress() {
    controllerx2.repeat(min: 0.0, max: 1.0, period: const Duration(seconds: 1));
    controllery2.repeat(min: 0.0, max: 1.0, period: const Duration(seconds: 1));
  }
////
  ///
  ///
  ///

  OverlayEntry? _overlayEntry;
  Size? buttonSize;
  Offset? buttonPosition;
  bool isMenuOpen = false;
  Offset beginningDragPosition = Offset.zero; //add
  Offset currentDragPosition = Offset.zero; //add

  List<Content> data = [
    Content(0, Icons.filter_1),
  ];

  void openMenu(GlobalKey key) {
    findButton(key);
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry!);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry!.remove();
    isMenuOpen = !isMenuOpen;
  }

  findButton(GlobalKey key) {
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  ///
  ///

  ///
  ///

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition!.dy + buttonSize!.height,
          left: buttonPosition!.dx,
          width: buttonSize!.width,
          child: const SizedBox.shrink(),
        );
      },
    );
  }

  ///
  ///
  ///

  DragTarget buildDragTarget(Content content) => DragTarget(
        builder: (context, candidateData, rejectedData) {
          GlobalKey key = LabeledGlobalKey(content.num.toString());

          return Listener(
            //add
            onPointerDown: (details) {
              if (isMenuOpen) closeMenu();
              beginningDragPosition = details.position;
            },
            onPointerMove: (details) {
              currentDragPosition = Offset(
                details.position.dx - beginningDragPosition.dx,
                details.position.dy - beginningDragPosition.dy,
              );
              if (currentDragPosition.distance > 20) {
                if (isMenuOpen) closeMenu();
              }
            },
            child: LongPressDraggable(
              key: key,
              data: content.num,
              maxSimultaneousDrags: 1,
              hapticFeedbackOnStart: true,
              onDragStarted: () {
                if (!isMenuOpen) {
                  openMenu(key);
                  startRotationEffectLongPress();
                  setState(() {
                    showEffectRotation = false;
                  });
                }
              },
              feedback: SizedBox(
                height: 150,
                width: 150,
                child: ObitAnimation(
                    controllerx: controllerx2, controllery: controllery2),
              ),
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.green,
                ),
              ),
            ),

            // buildDraggable("Draggable", content, key),
          );
        },
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {},
        onLeave: (data) {},
      );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      ///
      /// code dragbale widget
      ///
      ///

      // behavior: HitTestBehavior.opaque,
      onLongPress: () {
        if (isMenuOpen) {
          closeMenu();
        }

        print('object');
      },

      ///
      ///
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                // fit: StackFit.expand,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => startRotation(
                                    showEffectRotationLongPresse ? 2 : 20,
                                    showEffectRotationLongPresse ? 2 : 20),
                                child: Container(
                                  width: 215,
                                  height: 215,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/pic.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              showEffectRotation
                                  ? ObitAnimation(
                                      controllerx: controllerx,
                                      controllery: controllery)
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: size.width - 20,
                            height: 130,
                            child: Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "RTC - Mensuel - General",
                                      style: themeData.textTheme.bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                    ),
                                    const SizedBox(height: 5),
                                    const Center(
                                        child: Text("Periode de validite")),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "2022-05-01",
                                              style: themeData
                                                  .textTheme.bodyText2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0),
                                            ),
                                            const Text("00:00"),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "2022-05-31",
                                              style: themeData
                                                  .textTheme.bodyText2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0),
                                            ),
                                            const Text("23:59")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: size.width - 20,
                            height: 130,
                            child: Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Stack(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Positioned(
                                      left: 10,
                                      top: 0,
                                      bottom: 0,
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Icon(
                                          Icons.person,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          Text("Reserve au RTC",
                                              style: themeData
                                                  .textTheme.bodyText2),
                                          Text(
                                            "2022-05-09",
                                            style: themeData
                                                .textTheme.bodyText2!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0),
                                          ),
                                          const Text("17:01"),
                                          Text(
                                            "1-6E62C86342A",
                                            style: themeData
                                                .textTheme.bodyText2!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: buildDragTarget(data[0]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

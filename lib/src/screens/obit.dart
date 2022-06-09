import 'package:flutter/material.dart';
import 'package:obiteanimation/src/utils/app_theme.dart';
import 'package:obiteanimation/src/widgets/obitAnimation.dart';

class Orbit extends StatefulWidget {
  @override
  _Orbit createState() => _Orbit();
}

class _Orbit extends State<Orbit> with TickerProviderStateMixin {
  late AnimationController controllerx;
  late AnimationController controllery;
  bool showEffectRotation = false;
  @override
  void initState() {
    super.initState();
    controllerx = AnimationController(vsync: this);
    controllery = AnimationController(vsync: this);
  }

  void startRotation() {
    controllerx.repeat(min: 0.0, max: 1.0, period: const Duration(seconds: 20));
    controllery.repeat(min: 0.0, max: 1.0, period: const Duration(seconds: 20));
    setState(() {
      showEffectRotation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () => startRotation(),
          child: Container(
            width: 215,
            height: 215,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/images/pic.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        showEffectRotation
            ? ObitAnimation(controllerx: controllerx, controllery: controllery)
            : const SizedBox.shrink(),
        Positioned(
          bottom: 20,
          child: Column(
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
                          style: themeData.textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        const SizedBox(height: 5),
                        const Center(child: Text("Periode de validite")),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "2022-05-01",
                                  style: themeData.textTheme.bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                ),
                                const Text("00:00"),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "2022-05-31",
                                  style: themeData.textTheme.bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
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
                                  style: themeData.textTheme.bodyText2),
                              Text(
                                "2022-05-09",
                                style: themeData.textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              const Text("17:01"),
                              Text(
                                "1-6E62C86342A",
                                style: themeData.textTheme.bodyText2!.copyWith(
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
        ),
      ],
    );
  }
}

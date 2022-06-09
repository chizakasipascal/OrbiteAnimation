import 'package:flutter/material.dart';
import 'package:obiteanimation/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Orbit(),
          ),
        ),
      ),
    );
  }
}

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

class ObitAnimation extends StatelessWidget {
  const ObitAnimation({
    Key? key,
    required this.controllerx,
    required this.controllery,
  }) : super(key: key);

  final AnimationController controllerx;
  final AnimationController controllery;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        RotationTransition(
          turns: controllerx,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color.fromARGB(255, 42, 0, 231),
              ),
              height: 50.0,
              width: 50.0,
            ),
          ),
        ),
        RotationTransition(
          turns: controllery,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color.fromARGB(255, 255, 17, 0),
              ),
              height: 50.0,
              width: 50.0,
            ),
          ),
        ),
      ],
    );
  }
}

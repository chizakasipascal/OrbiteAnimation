import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 250,
            height: 250,
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

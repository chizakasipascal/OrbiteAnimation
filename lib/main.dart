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

  @override
  void initState() {
    super.initState();
    controllerx = AnimationController(vsync: this);
    controllerx.repeat(min: 0.0, max: 1.0, period: const Duration(seconds: 20));

    controllery = AnimationController(vsync: this);
    controllery.repeat(min: 0.0, max: 1.0, period: const Duration(seconds: 20));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 215,
          height: 215,
          decoration: const BoxDecoration(
            // color: const Color(0xFF0C7D0D).withOpacity(0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(120),
            ),
            image: DecorationImage(
              image: AssetImage("assets/images/pic.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        RotationTransition(
          turns: controllerx,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.green,
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
                color: Colors.red,
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

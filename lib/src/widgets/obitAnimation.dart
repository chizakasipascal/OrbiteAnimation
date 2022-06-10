import 'package:flutter/material.dart';

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
              height: 40.0,
              width: 40.0,
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
              height: 40.0,
              width: 40.0,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:obiteanimation/src/screens/obit.dart';
import 'package:obiteanimation/src/utils/app_theme.dart';

class OrbiteAnimation extends StatelessWidget {
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

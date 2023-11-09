import 'package:flutter/material.dart';

class ApplicationLogo extends StatelessWidget {
  const ApplicationLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('../lib/assets/gubukcinemalogo.png'),
      ],
    );
  }
}
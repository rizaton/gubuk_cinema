import 'package:flutter/material.dart';
import 'package:gubuk_cinema/ui/home_page.dart';

void main() => runApp(
  const MyApp(
    loggedOn: '0'
  )
);

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  final String loggedOn;
  const MyApp({
    super.key,
    required this.loggedOn
    });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gubuk Cinema',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(loggedOn: widget.loggedOn),
    );
  }
}
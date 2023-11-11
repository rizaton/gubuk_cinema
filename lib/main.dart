import 'package:flutter/material.dart';
import 'package:gubuk_cinema/ui/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const RunApplication());

class RunApplication extends StatelessWidget {
  const RunApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    super.initState();
    _initialData();
  }

  Future<void> _initialData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user',[
        '_ids',
        'name',
        'unam',
        'pass',
        'mail',
      ]
    );
    await prefs.setStringList('bookmark',[]);
    await prefs.setString('logged', 'false');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gubuk Cinema',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

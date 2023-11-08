import 'package:flutter/material.dart';
// import 'package:gubuk_cinema/ui/home_page.dart';
// import 'package:gubuk_cinema/ui/loginPage/login_page.dart';
import 'package:gubuk_cinema/ui/homePage/home_page.dart';
// import 'package:gubuk_cinema/ui/movie_list_page.dart';
// import 'package:gubuk_cinema/models/app_logo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gubuk Cinema',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   MyApp({super.key});
//   final routes = <String, WidgetBuilder>{
//     LoginPage.tag: (context) => const LoginPage(),
//     HomePage.tag: (context) => const HomePage(),
//     MovieListPage.tag: (context) => const MovieListPage(),
//   };
//   //const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Gubuk Cinema',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.lightBlue,
//         fontFamily: 'Nunito'
//       ),
//       home: const LoginPage(),
//       builder: (context, child){
//         return ScrollConfiguration(behavior: MyBehavior(), child: child!);
//       },
//       routes: routes,
//     );
//   }
// }

// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildOverscrollIndicator(
//       BuildContext context, Widget child, ScrollableDetails details) {
//     return child;
//   }
// }
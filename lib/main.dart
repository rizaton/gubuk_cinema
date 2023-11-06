import 'package:flutter/material.dart';
// import 'package:gubuk_cinema/ui/home_page.dart';
// import 'package:gubuk_cinema/ui/loginPage/login_page.dart';
// import 'package:gubuk_cinema/ui/movie_list_page.dart';
// import 'package:gubuk_cinema/models/app_logo.dart';
// import 'package:gubuk_cinema/ui/bookmarkPage/bookmark_page.dart';
// import 'package:gubuk_cinema/ui/homePage/home_page.dart';
import 'package:gubuk_cinema/ui/loginPage/login_page.dart';
// import 'package:gubuk_cinema/ui/loginPage/registration_page.dart';
// import 'package:gubuk_cinema/ui/movieOverview/movie_overview.dart';
import 'package:gubuk_cinema/ui/profilePage/profile_page.dart';
// import 'package:gubuk_cinema/ui/searchPage/search_page.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Gubuk Cinema',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.black,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const LoginPage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => const LoginPage(),
    ProfilePage.tag:(context) => const ProfilePage(),
  };
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gubuk Cinema',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito'
      ),
      home: const ProfilePage(),
      builder: (context, child){
        return ScrollConfiguration(behavior: MyBehavior(), child: child!);
      },
      routes: routes,
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
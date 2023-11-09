import 'package:flutter/material.dart';
import 'package:gubuk_cinema/ui/login_page.dart';
import 'package:gubuk_cinema/ui/registration_page.dart';

class DrawerNoLogin extends StatelessWidget {
  const DrawerNoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'My App Drawer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text("Log in"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Register"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Register(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Tentang Aplikasi"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

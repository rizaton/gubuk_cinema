import 'package:flutter/material.dart';
import 'package:gubuk_cinema/ui/login_page.dart';
import 'package:gubuk_cinema/ui/registration_page.dart';

class DrawerSide extends StatefulWidget {
  final String loggedOn;

  const DrawerSide({
    super.key,
    required this.loggedOn
    });

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  @override
  Widget build(BuildContext context) {
    if (widget.loggedOn == '1') {
      return const _DrawerLogged();
    } else {
      return const _DrawerNoLogged();
    }
  }
}

class _DrawerNoLogged extends StatelessWidget {
  const _DrawerNoLogged();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.asset('lib/assets/gubukcinemalogo.png',
                    ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: 
                (context) => const LoginPage()
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('Register'),
            onTap: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: 
                (context) => const Register()
                )
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Tentang Aplikasi'),
            onTap: () {
              // Handle User Settings action
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Handle Logout action
            },
          ),
        ],
      ),
    );
  }
}

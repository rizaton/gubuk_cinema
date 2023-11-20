import 'package:flutter/material.dart';
import 'package:gubuk_cinema/ui/bookmark_page.dart';
import 'package:gubuk_cinema/ui/login_page.dart';
import 'package:gubuk_cinema/ui/profile_page.dart';
import 'package:gubuk_cinema/ui/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerSide extends StatefulWidget {
  const DrawerSide({super.key});

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  String status = 'no_data';
  String name = '';

  @override
  void initState() {
    super.initState();
    _statusLogged();
  }

  Future<void> _statusLogged() async {
    final prefs = await SharedPreferences.getInstance();
    final nameState = prefs.getStringList('user')?[1];
    if (prefs.get('logged') == 'true') {
      setState(() {
        status = 'logged';
        name = nameState!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (status == 'logged') {
      return _DrawerLogged(name);
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
                Image.asset(
                  'lib/assets/gubukcinemalogo.png',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('Register'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Register()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              // Handle User Settings action
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerLogged extends StatelessWidget {
  final String name;

  const _DrawerLogged(this.name);

  Future<void> _loggedOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user', [
      '_ids',
      'name',
      'unam',
      'pass',
      'mail',
    ]);
    await prefs.setStringList('bookmark', []);
    await prefs.setString('logged', 'false');
  }

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
                Image.asset(
                  'lib/assets/gubukcinemalogo.png',
                ),
                Text('Welcome $name',
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Application'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const AppInfoPage()
              //   )
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Bookmark'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookmarkPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('User Settings'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              _loggedOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

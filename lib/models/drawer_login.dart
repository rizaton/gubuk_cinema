import 'package:flutter/material.dart';

class DrawerLogged extends StatelessWidget {
  const DrawerLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset('lib/assets/gubukcinemalogo.png',
                    ),
                Text('Welcome KAL', style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Application'),
            onTap: () {
              // Handle About Application action
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Bookmark'),
            onTap: () {
              // Handle Bookmark action
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('User Settings'),
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

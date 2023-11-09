import 'package:flutter/material.dart';

import 'package:gubuk_cinema/ui/login_page.dart';
import 'package:gubuk_cinema/ui/registration_page.dart';

class ProfilePage extends StatefulWidget {
  static String tag = 'profile-page';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newRePasswordController = TextEditingController();

  String oldUsername = 'Username Sebelumnya: ';
  String oldEmail = 'Email Sebelumnya: ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
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
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Container(
              height: 100,
              color: Colors.grey,
              child: Container(
                height: 50,
                width: 50,
                color: Colors.blue,
                child: Image.asset(
                  '../lib/assets/yukino.png',
                  // fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              const ListTile(
                title: Text('Ganti Username'),
              ),
              Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // Lebar sesuai dengan lebar perangkat
                color: const Color.fromARGB(255, 255, 255,
                    255), // Ganti dengan warna latar belakang yang diinginkan
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      enabled: false,
                      decoration: InputDecoration(labelText: oldUsername),
                    ),
                    TextFormField(
                      controller: usernameController,
                      enabled: true,
                      decoration:
                          const InputDecoration(labelText: 'Username Baru'),
                    ),
                    Container(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey
                          ),
                        ),
                        onPressed: (){
                          // Navigator.push(
                          //   context,
                            
                          //   ),
                        }, 
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              const ListTile(
                title: Text('Ganti Email'),
              ),
              Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // Lebar sesuai dengan lebar perangkat
                color: const Color.fromARGB(255, 255, 255,
                    255), // Ganti dengan warna latar belakang yang diinginkan
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      enabled: false,
                      decoration: InputDecoration(labelText: oldEmail),
                    ),
                    TextFormField(
                      controller: usernameController,
                      enabled: true,
                      decoration:
                          const InputDecoration(labelText: 'Email Baru'),
                    ),
                    Container(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey
                          ),
                        ),
                        onPressed: (){
                          // Navigator.push(
                          //   context,
                            
                          //   ),
                        }, 
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              const ListTile(
                title: Text('Ganti Password'),
              ),
              Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // Lebar sesuai dengan lebar perangkat
                color: const Color.fromARGB(255, 255, 255,
                    255), // Ganti dengan warna latar belakang yang diinginkan
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      enabled: true,
                      decoration: const InputDecoration(
                          labelText: 'Masukkan password lama'),
                    ),
                    TextFormField(
                      controller: usernameController,
                      enabled: true,
                      decoration: const InputDecoration(
                          labelText: 'Masukkan password baru'),
                    ),
                    TextFormField(
                      controller: usernameController,
                      enabled: true,
                      decoration: const InputDecoration(
                          labelText: 'Masukkan ulang password baru'),
                    ),
                    Container(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey
                          ),
                        ),
                        onPressed: (){
                          // Navigator.push(
                          //   context,
                            
                          //   ),
                        }, 
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          ),
          // Add more ListTiles for additional fields
        ],
      ),
    );
  }
}

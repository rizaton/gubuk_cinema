import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gubuk_cinema/models/http_api.dart';
import 'package:gubuk_cinema/ui/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String loggedOn = '';
  String pesan = '';

  @override
  void initState(){
    super.initState();
    _login();
  }

  Future<List> _login () async {
    var uri = await getAPIAccount();
    List<dynamic> dataUserJson = json.decode(uri);
    return dataUserJson;
  }

  Future<void> _logged(
      String ids, 
      String fullname, 
      String username, 
      String password, 
      String email,
      List<dynamic> bookmark) async {
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user',[
        ids,
        fullname,
        username,
        password,
        email,
      ]
    );
    await prefs.setString('logged', 'true');
    if (bookmark.isEmpty) {
      await prefs.setStringList('bookmark',
       []
      );
    } else {
      List<String> tempBookmark = [];
      for (var i = 0; i < bookmark.length; i++) {
        tempBookmark.add(bookmark[i]);
      }
      await prefs.setStringList('bookmark',
        tempBookmark
      );
    }
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _login(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List? dataUserJson = snapshot.data;

          var ids = [];
          var fullname = [];
          var username = [];
          var password = [];
          var email = [];
          var bookmark = [];

          for (var i = 0; i < dataUserJson!.length; i++) {
            ids.add('${dataUserJson[i]['_id']}');
            fullname.add(dataUserJson[i]['fullname']);
            username.add(dataUserJson[i]['username']);
            password.add(dataUserJson[i]['password']);
            email.add(dataUserJson[i]['email']);
            bookmark.add(dataUserJson[i]['bookmark']);
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                'Halaman Login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  Container(
                    height: 30,
                  ),
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      "lib/assets/gubukcinemalogo.png",
                      height: 150,
                      width: 150,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Colors.grey),
                            ),
                            elevation: 10,
                            minimumSize: const Size(200, 50)
                          ),
                          onPressed: () {
                            if (username.contains(usernameController.text) == false) {
                                loggedOn = 'no_data';
                                pesan = 'Data tidak ditemukan';
                            } else if (password.contains(passwordController.text) == false){
                                loggedOn = 'no_data';
                                pesan = 'Data yang anda masukkan salah';
                            } else if (
                              username.contains(usernameController.text) &&
                              password.contains(passwordController.text)
                              ){
                              if (
                                username.indexOf(usernameController.text) == password.indexOf(passwordController.text)
                              ) {
                                _logged(
                                  ids[username.indexOf(usernameController.text)], 
                                  fullname[username.indexOf(usernameController.text)], 
                                  username[username.indexOf(usernameController.text)], 
                                  password[username.indexOf(usernameController.text)], 
                                  email[username.indexOf(usernameController.text)], 
                                  bookmark[username.indexOf(usernameController.text)]
                                );
                                loggedOn = 'logged';
                                pesan = 'Selamat datang kembali';

                              } else {
                                  loggedOn = 'no_data';
                                  pesan = 'Telah terjadi kesalahan';
                              }
                            } else {
                                loggedOn = 'no_data';
                                pesan = 'Telah terjadi kesalahan';
                            }
                            _showToast(context, pesan);
                            if (loggedOn == 'logged') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage()
                                ),
                              );
                            }
                          },
                          child: const Text("Login"),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
                          child: TextButton(
                            child: const Text("Lupa Password?"),
                            onPressed: () {},
                          )
                      ),
                    ]
                  ),
                ],
              ),
            )
          )
        );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

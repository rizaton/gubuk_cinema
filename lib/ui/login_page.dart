import 'package:flutter/material.dart';
import 'package:gubuk_cinema/models/http_api.dart';
import 'package:gubuk_cinema/ui/page_home.dart';
import 'package:gubuk_cinema/ui/registration_page.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  Future<void> loginPostRequest() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    if (usernameController.text.isEmpty) {
      setState(() {errorMessage = 'Username tidak boleh kosong';});
      isLoading = false;
      return;}
    if (passwordController.text.isEmpty) {
      setState(() {errorMessage = 'Password tidak boleh kosong';});
      isLoading = false;
      return;}

    try{
        String body = jsonEncode({
          'username' : usernameController.text,
          'password' : passwordController.text,
        });
        var response = await loginAccount(body);

      if(response.statusCode == 200){
        final res = json.decode(response.body);
        if(res['message'] == null){
          await prefs.setStringList('user', [
            res['result']['_id'],
            res['result']['username'],
            res['result']['fullname'],
            res['result']['email'],
            res['result']['password'],
          ]);
          await prefs.setBool('login', true);
          final queryParameters = {
            'id_user': res['result']['_id'],
          };
          var bookmarkRes = await getBookmark(queryParameters);
          var mapJson = json.decode(bookmarkRes.body);
          List<String> jsonBookmarks = (mapJson['bookmark_movie'] as List).map((item) => item as String).toList();

          await prefs.setString('bookmark_id', mapJson['_id']);
          await prefs.setStringList('bookmark_movie', jsonBookmarks );
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context, 
              MaterialPageRoute(builder: (context) => const PageHome()));
      } else {
          setState(() {
            errorMessage = 'Username atau Password Salah!';
          });
        }
      }
      else{
        setState(() {
          errorMessage = 'Gagal melakukan login. Silakan coba lagi.';
        });
      }
    } catch(error) {
        setState(() {
          errorMessage = 'Terjadi kesalahan. Silakan coba lagi.\n$error';
        });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gubuk Cinema"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 30,
              ),
              Image.asset(
                'lib/assets/gubukcinemalogo.png', height: 150, width: 150
              ),
              const SizedBox(height: 30,),
              const Text("LOGIN", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              Column(
                children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  child: _fieldUsername()
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  child: _fieldPassword()
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  child: _tombolLogin()
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
                  child: _lupaPassword()
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
                  child: _register()
                ),
                const SizedBox(height: 8),
                if (isLoading) const CircularProgressIndicator(),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ]
              )
            ],
          ),
        )
      )
    );
  }

  _fieldUsername(){
    return TextFormField( 
      controller: usernameController,
      decoration: const InputDecoration(
        labelText: 'Username'
      )
    );
  }

  _fieldPassword(){
    return TextFormField( 
      controller: passwordController,
      decoration: const InputDecoration(
        labelText: 'Password'
      )
    );
  }

  _tombolLogin(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Colors.grey),
        ),
        elevation: 10,
        minimumSize: const Size(200, 50)
      ),
      onPressed: (){
        loginPostRequest();
      },
      child: const Text("Login")
    );
  }

  _lupaPassword(){
    return TextButton(
      child: const Text("Lupa Password?"),
      onPressed: () {
      },
    );
  }

  _register(){
    return TextButton(
      child: const Text("Belum punya akun? Daftar Disini"),
      onPressed: () {
        Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => const Register()));
      },
    );
  }
}
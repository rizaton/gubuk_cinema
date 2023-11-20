import 'package:flutter/material.dart';
import 'package:gubukcinema/ui/home_page.dart';
import 'package:gubukcinema/ui/registration_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    const String apiurl = "gubukcinema.vercel.app";

    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    
    try{
      http.Response response = await http.post(
        Uri.https(apiurl, '/api/login'),
        body: jsonEncode({
          'username' : usernameController.text,
          'password' : passwordController.text,
        }),
      );

      if(response.statusCode == 200){
        final res = json.decode(response.body);
        //print(res['message']);
        if(res['message'] == null){
          final _id = res['result']['_id'];
          final username = res['result']['username'];
          final fullname = res['result']['fullname'];
          final email = res['result']['email'];
          final password = res['result']['password'];
          //print(_id);
          Navigator.pushReplacement(context, 
              MaterialPageRoute(builder: (context) => HomePage()));
        }
        else{
          setState(() {
            errorMessage = 'Username atau Password Salah!';
          });
        }
      }
      else{
        print('Error: ${response.reasonPhrase}');
        setState(() {
          errorMessage = 'Gagal melakukan login. Silakan coba lagi.';
        });
        //throw Exception('Failed to load data');
      }
    } catch(error) {
        print('Error: $error');
        setState(() {
          errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
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
      ),
      body: SingleChildScrollView(
        child: 
          Center(
            child: Column(
              children: [
                Container(
                  height: 30,
                ),
                Container(
                  child: Image.asset("assets/pb.png", height: 150, width: 150,),
                ),
                SizedBox(height: 30,),
                Container(
                  child: Text("LOGIN", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                ),
                Container(
                  child: Column(
                    children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: _fieldUsername()
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: _fieldPassword()
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: _tombolLogin()
                      )
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
                        child: _LupaPassword()
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
                        child: _Resgister()
                      ),
                    ),
                    SizedBox(height: 8),
                    if (isLoading) CircularProgressIndicator(),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ]
                  )
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
      decoration: InputDecoration(
        labelText: 'Username'
    ));
  }

  _fieldPassword(){
    return TextFormField( 
      controller: passwordController,
      decoration: InputDecoration(
        labelText: 'Password'
    ));
  }

  _tombolLogin(){
    return ElevatedButton(
      child: const Text("Login"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Colors.blue),
        ),
        elevation: 10,
        minimumSize: Size(200, 50)
      ),
      onPressed: (){
        loginPostRequest();
      }
    );
  }

  _LupaPassword(){
    return TextButton(
      child: const Text("Lupa Password?"),
      onPressed: () {
        
    },
    );
  }

  _Resgister(){
    return TextButton(
      child: const Text("Belum punya akun? Daftar Disini"),
      onPressed: () {
        Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => Register()));
    },
    );
  }
}
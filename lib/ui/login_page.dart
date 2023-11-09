import 'package:flutter/material.dart';
import 'package:gubuk_cinema/ui/movie_list_page.dart';


class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        child: TextFormField( 
                          controller: usernameController,
                          decoration: InputDecoration(
                          labelText: 'Username'
                        )),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: TextFormField( 
                          controller: passwordController,
                          decoration: InputDecoration(
                          labelText: 'Password'
                        )),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: ElevatedButton(
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
                          onPressed: (){},
                        ),
                      )
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
                        child: TextButton(
                          child: const Text("Lupa Password?"),
                          onPressed: () {
                            
                          },
                        )
                      ),
                    )
                    ]
                  )
                )
                ],
                  ),
                )
        )
      );
  }
}
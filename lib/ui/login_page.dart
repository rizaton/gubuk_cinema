import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                          decoration: const InputDecoration(
                          labelText: 'Username'
                        )),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: TextFormField( 
                          controller: passwordController,
                          decoration: const InputDecoration(
                          labelText: 'Password'
                        )),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.blue),
                            ),
                            elevation: 10,
                            minimumSize: const Size(200, 50)
                          ),
                          onPressed: (){},
                          child: const Text("Login"),
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
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:gubuk_cinema/models/http_api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reenterPasswordController =
      TextEditingController();

  Future<void> registerUser() async {
    final String username = usernameController.text;
    final String fullname = fullnameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    final Map<String, dynamic> userData = {
      'username': username,
      'fullname': fullname,
      'email': email,
      'password': password,
    };

    final String jsonData = jsonEncode(userData);

    postAPIAccount(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Halaman Pendaftaran'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Daftar Akun',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Isi informasi berikut untuk mendaftar:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                controller: usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama'),
                controller: fullnameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: passwordController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ulangi Password'),
                obscureText: true,
                controller: reenterPasswordController,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  Text('Saya setuju dengan Persyaratan dan Ketentuan'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  registerUser();
                },
                child: Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Halaman Pendaftaran',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Daftar Akun',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Isi informasi berikut untuk mendaftar:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                controller: usernameController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama'),
                controller: fullnameController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: passwordController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ulangi Password'),
                obscureText: true,
                controller: reenterPasswordController,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text('Saya setuju dengan Persyaratan dan Ketentuan'),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
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
                  registerUser();
                },
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      );
  }
}

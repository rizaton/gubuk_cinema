import 'package:flutter/material.dart';

class MovieListPage extends StatelessWidget {
  static String tag = 'movie-page';
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Film"),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 20.0),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 260,
                                        width: 160,
                                        child: Image.asset("../lib/assets/indigo.jpg", fit: BoxFit.fill,),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Indigo")
                                    ],
                                  )
                                ],
                              )
                            ),
                            const SizedBox(width: 20.0),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 260,
                                        width: 160,
                                        child: Image.asset("../lib/assets/indigo.jpg", fit: BoxFit.fill,),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Indigo")
                                    ],
                                  )
                                ],
                              )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Kolom 1, Baris 2")
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text("Row 1")
                      ],
                    ),
                    Row(
                      children: [
                        Text("Row 2")
                      ],
                    ),
                    Row(
                      children: [
                        Text("Row 3")
                      ],
                    ),
                  ]
                ),
              ),
            )
          )
        ]
        ),
    );
  }
}
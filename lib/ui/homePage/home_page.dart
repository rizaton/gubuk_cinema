import 'package:flutter/material.dart';
import 'package:gubuk_cinema/ui/loginPage/login_page.dart';
import 'package:gubuk_cinema/ui/loginPage/registration_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 70.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Gubuk Cinema',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SizedBox(
                  height: 400,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(index),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.blue,
                          child: Image.asset(
                            '../lib/assets/indigo.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              title: Text('Deskripsi Item $index',
                                  style: const TextStyle(color: Colors.black)),
                              subtitle: const Text('Rating: 4.5',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
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
                    builder: (context) => const Registration(),
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
    );
  }
}

class DetailPage extends StatelessWidget {
  final int index;

  const DetailPage(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Detail Item $index'),

      ),
      body: Center(
        child: Text('Detail dari item $index'),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: ListView(
  //       scrollDirection: Axis.vertical,
  //       children: [
  //         Column(
  //           children: [
  //             SizedBox(
  //               width: double.infinity,
  //               child: Stack(
  //                 children: [
  //                   Container(
  //                     width: double.infinity,
  //                     height: 70,
  //                     color: const Color.fromARGB(255, 0, 0, 0),
  //                     child: Stack(
  //                       children: [
  //                         Align(
  //                           alignment: Alignment.center,
  //                           child: Container(
  //                             width: 165,
  //                             height: 40,
  //                             decoration: const BoxDecoration(
  //                                 color: Color.fromARGB(255, 170, 0, 0)),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 15,
  //                           left: 20,
  //                           child: Container(
  //                             width: 40,
  //                             height: 40,
  //                             decoration: const BoxDecoration(
  //                                 color: Color.fromARGB(255, 180, 112, 112)),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               width: double.infinity,
  //               child: Stack(
  //                 children: [
  //                   Container(
  //                     width: double.infinity,
  //                     height: 50,
  //                     decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
  //                     child: Stack(
  //                       children: [
  //                         Align(
  //                           alignment: Alignment.center,
  //                           child: Container(
  //                             width: 300,
  //                             height: 40,
  //                             decoration: const BoxDecoration(
  //                                 color: Color.fromARGB(255, 116, 116, 116)),
  //                           ),
  //                         ),
  //                         Align(
  //                           alignment: Alignment.center,
  //                           child: Container(
  //                             width: 290,
  //                             height: 30,
  //                             decoration: const BoxDecoration(
  //                                 color: Color.fromARGB(255, 185, 185, 185)),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 10,
  //                           left: 310,
  //                           child: Container(
  //                             width: 30,
  //                             height: 30,
  //                             decoration: const BoxDecoration(
  //                                 color: Color.fromARGB(255, 101, 100, 100)),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               width: double.infinity,
  //               child: Stack(
  //                 children: [
  //                   Container(
  //                     width: double.infinity,
  //                     height: 70,
  //                     color: const Color.fromARGB(255, 116, 116, 116),
  //                     child: Stack(
  //                       children: [
  //                         Positioned(
  //                           top: 15,
  //                           left: 20,
  //                           child: Container(
  //                             width: 40,
  //                             height: 40,
  //                             decoration: const BoxDecoration(
  //                                 color: Color.fromARGB(255, 145, 144, 144)),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
// }

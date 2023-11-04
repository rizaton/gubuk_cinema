import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 360,
    height: 800,
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(color: Colors.white),
    child: Stack(
        children: [
            Positioned(
                left: 0,
                top: 765,
                child: Container(
                    width: 360,
                    height: 35,
                    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
            ),
            Positioned(
                left: 0,
                top: 80,
                child: SizedBox(
                    width: 360,
                    height: 50,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 360,
                                    height: 50,
                                    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 25,
                                top: 4,
                                child: Container(
                                    width: 310,
                                    height: 40,
                                    decoration: const BoxDecoration(color: Color(0xFF9A8383)),
                                ),
                            ),
                            Positioned(
                                left: 298,
                                top: 11,
                                child: Container(
                                    width: 30,
                                    height: 28,
                                    decoration: const BoxDecoration(color: Color(0xFF747474)),
                                ),
                            ),
                            Positioned(
                                left: 30,
                                top: 11,
                                child: Container(
                                    width: 260,
                                    height: 28,
                                    decoration: const BoxDecoration(color: Colors.white),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 10,
                top: 140,
                child: SizedBox(
                    width: 340,
                    height: 620,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 340,
                                    height: 620,
                                    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 20,
                                top: 20,
                                child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                            Positioned(
                                left: 190,
                                top: 20,
                                child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                            Positioned(
                                left: 20,
                                top: 170,
                                child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                            Positioned(
                                left: 190,
                                top: 170,
                                child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                            Positioned(
                                left: 20,
                                top: 320,
                                child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                            Positioned(
                                left: 190,
                                top: 320,
                                child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                            Positioned(
                                left: 20,
                                top: 470,
                                child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                            Positioned(
                                left: 190,
                                top: 470,
                                child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 360,
                    height: 70,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 360,
                                    height: 70,
                                    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 115,
                                top: 15,
                                child: Container(
                                    width: 165,
                                    height: 40,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                            Positioned(
                                left: 20,
                                top: 15,
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(color: Color(0xFF636363)),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ],
    ),
);
  }
}
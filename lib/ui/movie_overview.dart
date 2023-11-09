import 'package:flutter/material.dart';

class OverviewMovie extends StatefulWidget {
  const OverviewMovie({super.key});

  @override
  State<OverviewMovie> createState() => _OverviewMovieState();
}

class _OverviewMovieState extends State<OverviewMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {
            Navigator.of(context)
                .pop(); // Tindakan kembali ke halaman sebelumnya
          },
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 600, // Tinggi AppBar saat diperluas
            pinned: false, // Tidak perlu pin AppBar
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "../lib/assets/indigo.jpg", // Ganti URL gambar dengan yang sesuai
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Hellow",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 5), // Tambahkan padding ke ikon
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ),
                      Text(
                        '4.5 | 2 Jam', // Teks Anda
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                          "lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet. lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet. lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet. "),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black, // Warna latar belakang badge
                              borderRadius:
                                  BorderRadius.circular(5), // Bentuk badge
                            ),
                            child: Text(
                              "Horror",
                              style: TextStyle(
                                color: Colors.white, // Warna teks pada badge
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black, // Warna latar belakang badge
                              borderRadius:
                                  BorderRadius.circular(5), // Bentuk badge
                            ),
                            child: Text(
                              "Comedy",
                              style: TextStyle(
                                color: Colors.white, // Warna teks pada badge
                              ),
                            ),
                          ),
                        ],
                      )),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi yang akan diambil ketika tombol ditekan
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Warna latar belakang tombol
                      onPrimary: Colors.white, // Warna teks pada tombol
                      padding:
                          EdgeInsets.symmetric(vertical: 20), // Padding tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            6), // Bentuk tombol (bulat dengan radius 8)
                      ),
                    ),
                    child: Container(
                      width:
                          500, // Mengatur lebar konten tombol menjadi 200 piksel
                      child: Center(
                        child: Text('Bookmark', textAlign: TextAlign.center),
                      ),
                    ), // Teks di dalam tombol
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

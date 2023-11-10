import 'package:flutter/material.dart';

class OverviewMovie extends StatefulWidget {
  final String linkMovie;
  final String titleMovie;
  final String ratingMovie;
  final String overviewMovie;
  final double popularityMovie;

  final List<dynamic> genreMovie;

  const OverviewMovie({
    super.key, 
    required this.linkMovie, 
    required this.titleMovie, 
    required this.ratingMovie, 
    required this.overviewMovie, 
    required this.popularityMovie, 
    required this.genreMovie,
    });

  @override
  State<OverviewMovie> createState() => _OverviewMovieState();
}

class _OverviewMovieState extends State<OverviewMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: 
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 600,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.linkMovie, 
                fit: BoxFit.fitWidth,
              ),
            ),
            leading: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(64, 0, 0, 0)
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.titleMovie,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
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
                        '${widget.ratingMovie} |  ', // Teks Anda
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 5), // Tambahkan padding ke ikon
                        child: Icon(
                          Icons.people,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${widget.popularityMovie}', // Teks Anda
                        style: const TextStyle(fontSize: 16),
                      ),

                    ],
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          widget.overviewMovie
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: List.generate(widget.genreMovie.length,
                      (index) => Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.circular(5),
                              ),
                              child: Text(
                                widget.genreMovie[index]['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                            width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                      child: const Center(
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

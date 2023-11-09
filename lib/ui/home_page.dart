import 'package:flutter/material.dart';
import 'package:gubuk_cinema/ui/login_page.dart';
import 'package:gubuk_cinema/ui/registration_page.dart';

import 'package:gubuk_cinema/models/http_api.dart';
import 'dart:convert';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List> dataFetch() async {
      var uri = await getAPIMovies();
      List<dynamic> jsonData = json.decode(uri);
      return jsonData;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 70.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Gubuk Cinema ',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverPersistentHeader(
            delegate: MySliverAppBarDelegate(
              minHeight: 40,
              maxHeight: 40,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 14,
                      child: Container(
                        color: Colors.white,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari Judul Film...',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      fit: FlexFit.loose,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey),
                        ),
                        onPressed: () {},
                        child: const Text('Cari'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 0.5,
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return FutureBuilder(
                  future: dataFetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {

                      final movieLinks = [];
                      final movieTitles = [];
                      final moviePopularities = [];
                      final List? jsonData = snapshot.data;

                      for (var links in jsonData!) {
                        String movieLink = links['poster_path'];
                        String movieTitle = links['original_title'];
                        double moviePopularity = links['popularity'];
                        movieLinks.add(movieLink);
                        movieTitles.add(movieTitle);
                        moviePopularities.add(moviePopularity);
                      }
                      return InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(index),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 5,
                              child: Image.network(
                                movieLinks[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(movieTitles[index],
                                      style: const TextStyle(
                                          color: Colors.black)),
                                  subtitle: Text('Popularity: ${moviePopularities[index]}',
                                      style: const TextStyle(color: Colors.black)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                );
              },
              childCount: 10,
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

class MySliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  MySliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

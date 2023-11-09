import 'package:flutter/material.dart';
// import 'package:gubuk_cinema/models/drawer.dart';
import 'package:gubuk_cinema/models/drawer_login.dart';
import 'package:gubuk_cinema/models/http_api.dart';
import 'dart:convert';

import 'movie_overview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List> dataFetch() async {
      var uri = await getAPIMovies();
      List<dynamic> jsonData = json.decode(uri);
      return jsonData;
    }
  TextEditingController searchController = TextEditingController();

    return FutureBuilder(
      future: dataFetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final movieLinks = [];
          final movieTitles = [];
          final movieRatings = [];
          final movieOverviews = [];
          final moviePopularities = [];
          final List? jsonData = snapshot.data;

          for (var links in jsonData!) {
            String movieLink = links['poster_path'];
            String movieTitle = links['original_title'];
            String movieRating = "${links['vote_average']}";
            String movieOverview = links['overview'];
            double moviePopularity = links['popularity'];


            movieLinks.add(movieLink);
            movieTitles.add(movieTitle);
            movieRatings.add(movieRating);
            movieOverviews.add(movieOverview);
            moviePopularities.add(moviePopularity);
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
                              child: TextFormField(
                                controller: searchController,
                                enabled: true,
                                decoration: const InputDecoration(
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
                              onPressed: () {
                                postAPIMovies(
                                  ""
                                );
                              },
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
                      return InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OverviewMovie(
                                linkMovie: movieLinks[index],
                                titleMovie: movieTitles[index],
                                ratingMovie: movieRatings[index],
                                overviewMovie: movieOverviews[index],
                                popularityMovie: moviePopularities[index],
                              ),
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
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  subtitle: Text(
                                      'Popularity: ${moviePopularities[index]}',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 14,
                  ),
                ),
              ],
            ),
            drawer:  const DrawerLogged(),
          );
        }
        return const CircularProgressIndicator();
      },
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

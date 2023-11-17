import 'package:flutter/material.dart';
import 'package:gubuk_cinema/models/drawer.dart';

import 'package:gubuk_cinema/models/http_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<String> bookmarked = [];

  Future<List> _dataFetch() async {
    var uri = await getAPIMovies();
    List<dynamic> jsonData = json.decode(uri);

    final prefs = await SharedPreferences.getInstance();
    List<String> bookData = prefs.getStringList('bookmark')!;

    setState(() {
      bookmarked = bookData;
    });

    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List? jsonData = snapshot.data;
          final movieIDs = []; 
          final movieLinks = [];
          final movieTitles = [];
          final movieRatings = [];
          final movieOverviews = [];
          final moviePopularities = [];
          final movieGenres = [];

          for (var links in jsonData!) {
            String movieLink = links['poster_path'];
            String movieTitle = links['original_title'];
            String movieRating = "${links['vote_average']}";
            String movieOverview = links['overview'];
            String movieID = "${links['_id']}";
            double moviePopularity = links['popularity'];
            List<dynamic> movieGenre = links['genres'];

            movieIDs.add(movieID);
            movieLinks.add(movieLink);
            movieTitles.add(movieTitle);
            movieRatings.add(movieRating);
            movieOverviews.add(movieOverview);
            moviePopularities.add(moviePopularity);
            movieGenres.add(movieGenre);
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
                      'Daftar Bookmark',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    centerTitle: true,
                  ),
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
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => OverviewMovie(
                        //         idMovie: movieIDs[index],
                        //         linkMovie: movieLinks[index],
                        //         titleMovie: movieTitles[index],
                        //         ratingMovie: movieRatings[index],
                        //         overviewMovie: movieOverviews[index],
                        //         popularityMovie: moviePopularities[index],
                        //         genreMovie: movieGenres[index],
                        //       ),
                        //     ),
                        //   );
                        // },
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
            drawer: const DrawerSide(),
          );
        }
        return const CircularProgressIndicator();
      },
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

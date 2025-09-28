import 'dart:async';
import 'dart:convert';
import '../models/http_api.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'movie_overview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Search',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

// class MySliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   MySliverAppBarDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });

//   @override
//   double get minExtent => minHeight;

//   @override
//   double get maxExtent => maxHeight;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  static List<Movie> _searchResults = []; // Hasil data dari API
  List<Movie> matchQuery =
      List.from(_searchResults); // Hasil pencarian dari fungsi _searchLocal()
  bool _isLoading = false;
  Timer? delay;
  ////// Uncomment jika ingin gunakan data local
  // void data() async {// +_LOKAL_+
  //   var uri = await getAPIMovies();
  //   List<dynamic> results = json.decode(uri);
  //   _searchResults = results.map((data) => Movie.fromJson(data)).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: MySliverAppBarDelegate(
          //     minHeight: 20,
          //     maxHeight: 20,
          //     child:
          //   ),
          // ),
          SliverAppBar(
            expandedHeight: 40.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.all(8.0),
              title: TextFormField(
                controller: _searchController,
                ////// Gunakan salah satu mau menggunakan onChanged atau onFieldSubmitted //////
                // onTap: () => data(),
                // onChanged: (query) {
                //   ////// Untuk cari data dari lokal //////
                //   _searchLocal(query);// +_LOKAL_+

                //   ////// Kalau onChanged mau ngambil datanya dari API uncomment kode dibawah //////
                //   // if (delay?.isActive ?? false) delay?.cancel();
                //   // delay = Timer(const Duration(milliseconds: 800), () {
                //   //   _search(query);
                //   // });
                // },
                ////// onFieldSubmitted kalau mau pakai data dari API
                onFieldSubmitted: (query) {
                  // +_API_+
                  _search(query);
                },
                cursorColor: Colors.black87,
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  // suffixIcon: IconButton(
                  //     onPressed: () {
                  //       _search(_searchController.text);
                  //     },
                  //     icon: Icon(Icons.search)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ),
          ),
          _isLoading
              ? SliverFillRemaining(
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                )
              : _buildResults(),
        ],
      ),
    );
  }

  Widget _buildResults() {
    /// Jika _searchResult kosong
    if (_searchResults.isEmpty) {
      // +_API_+
      return SliverFillRemaining(
        child: Align(
          alignment: Alignment.center,
          child: Text('No results found.'),
        ),
      );
    }

    /// Jika matchQuery kosong
    /// Note : Comment Jika menggunakan API
    // if (matchQuery.isEmpty) {// +_LOKAL_+
    //   return SliverFillRemaining(
    //     child: Align(
    //       alignment: Alignment.center,
    //       child: Text('No results found.'),
    //     ),
    //   );
    // }

    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          ////// Ganti variabel movie dan childCount sesuai dengan list yang digunakan
          (BuildContext context, int index) {
            /// Note : untuk variabel movie hanya ada 2 instance yaitu _searchResults dan matchQuery
            // Movie movie = matchQuery[index]; // +_LOKAL_+
            Movie movie = _searchResults[index]; // +_API_+
            return _buildMovieCard(movie);
          },

          /// Note : ganti juga List mana yang akan digunakan untuk mendapatkan lenght-nya
          // childCount: matchQuery.length, // +_LOKAL_+
          childCount: _searchResults.length, // +_API_+
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.5,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0));
  }

  Widget _buildMovieCard(Movie movie) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: () {
            //Uncomment Navigator.push kalau gatau bingung mau isi apa
            // Navigator.push(context, MaterialPageRoute(builder: (context) => MovieOverview(movie)));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              gradient: LinearGradient(
                  colors: List.unmodifiable([
                    Color.fromRGBO(0, 0, 0, 1.0),
                    Color.fromRGBO(100, 100, 100, 1.0)
                  ]),
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      height: 350,
                    ),
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black.withOpacity(0.6),
                          ),
                          // ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              SizedBox(width: 3.5),
                              Text(
                                movie.rating,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    movie.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          )),
    );
  }

  ////// Untuk cari data menggunakan API //////
  /// Note : fungsi getAPIMovies() di http_api.dart dan di dalam function Future dibawah ini harus di edit juga jika mau menggunakan API untuk search data
  Future<void> _search(String query) async {
    // +_API_+
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = true;
    });
    /// Note : hilangkan parameter pada getAPIMovies() jika di http_api.dart tidak menerima parameter
    var uri = await getMovies(); 
    List<dynamic> results = json.decode(uri);
    if (results != []) {
      setState(() {
        _searchResults = results.map((data) => Movie.fromJson(data)).toList();
        _isLoading = false;
      });
      _searchResults.forEach((element) {
        print(element.title);
      });
    }
    //else {
    //   // Handle error
    //   setState(() {
    //     _searchResults.clear();
    //   });
    //   print('Failed to load search results');
    // }
  }

  void _searchLocal(String query) {
    // matchQuery = List.from(_searchResults); //.where((element) => element.title)
    // if
    setState(() {
      matchQuery = _searchResults
          .where((element) =>
              element.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    print(_searchResults
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList());
  }
}

class Movie {
  final String idMovie;
  final String title;
  final String rating;
  final String posterPath;
  final String overview;
  final double popularity;

  final List<dynamic> genres;
  Movie(
      {required this.idMovie,
      required this.title,
      required this.rating,
      required this.posterPath,
      required this.overview,
      required this.popularity,
      required this.genres});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        idMovie: json['_id'],
        title: json['title'],
        rating: json['vote_average'].toString(),
        posterPath: json['poster_path'],
        overview: json['overview'],
        popularity: json['popularity'],
        genres: json['genres']);
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:gubuk_cinema/models/http_api.dart';
import 'package:flutter/material.dart';
import 'package:gubuk_cinema/ui/page_overview.dart';

class PageSearch extends StatefulWidget {
  final String searchTextQuery;
  const PageSearch({super.key, required this.searchTextQuery});

  @override
  State<PageSearch> createState() => _PageSearchState();
}

class _PageSearchState extends State<PageSearch> {
  final TextEditingController _searchController = TextEditingController();
  static List<Movie> _searchResults = [];
  List<Movie> matchQuery = List.from(_searchResults);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchTextQuery;
  }
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
            backgroundColor: Colors.white,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // titlePadding: const EdgeInsets.all(8.0),
              titlePadding: const EdgeInsets.only(left: 60.0,bottom: 8.0,right: 20,top: 8.0),
              title: TextFormField(
                controller: _searchController,
                onFieldSubmitted: (query) {
                  _search(query);
                },
                cursorColor: Colors.black87,
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black45, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _search(_searchController.text);
                      },
                    icon: const Icon(Icons.search_sharp),
                    splashRadius: 20,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    // splashColor: Colors.transparent,
                    // highlightColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            leading: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color.fromARGB(0, 255, 255, 255)),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                splashRadius: 20,
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                // hoverColor: Colors.transparent,
                // focusColor: Colors.transparent,
                // splashColor: Colors.transparent,
                // highlightColor: Colors.transparent,
              ),
            ),
          ),
          _isLoading
          ? const SliverFillRemaining(
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : _buildResults(context),
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context) {
    final int currentCount = (MediaQuery.of(context).size.width ~/ 250).toInt();
    const int minCount = 2;
    /// Jika _searchResult kosong
    if (_searchResults.isEmpty) {
      // +_API_+
      return const SliverFillRemaining(
        child: Align(
          alignment: Alignment.center,
          child: Text('No results found.'),
        ),
      );
    }

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
        crossAxisCount: max(currentCount, minCount),
        childAspectRatio: 0.5,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0
      ),
    );
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
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => PageOverview(idMovie: movie.idMovie)
            )
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            gradient: LinearGradient(
              colors: List.unmodifiable([
                const Color.fromRGBO(0, 0, 0, 1.0),
                const Color.fromRGBO(100, 100, 100, 1.0)
              ]),
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    height: 350,
                    loadingBuilder: (
                      BuildContext context, 
                      Widget child, 
                      ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
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
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          const SizedBox(width: 3.5),
                          Text(
                            movie.rating,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  movie.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  ////// Untuk cari data menggunakan API //////
  /// Note : fungsi getAPIMovies() di http_api.dart dan di dalam function Future dibawah ini harus di edit juga jika mau menggunakan API untuk search data
  Future<void> _search(String queryText) async {
    // +_API_+
    if (queryText.isEmpty) {
      setState(() {
        _searchResults.clear();
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = true;
    });
    /// Note : hilangkan parameter pada getAPIMovies() jika di http_api.dart tidak menerima parameter
    if ('' != queryText) {
      String rawQuery = queryText;
      String replacedQuery = rawQuery.replaceAll(" ","_").replaceAll(":","`");
      var queryParameters = {
        "title": replacedQuery,
      };
      var resultBody = await findMovie(queryParameters);
      _setMovie(resultBody);
    } else {
      var resultBody = await getMovies();
      _setMovie(resultBody);
    }
  }
  Future<void> _setMovie(String dataJson) async {
    List<dynamic> results = json.decode(dataJson);
    if (results != []) {
      setState(() {
        _searchResults = results.map((data) => Movie.fromJson(data)).toList();
        _isLoading = false;
      });
    }
    else {
      setState(() {
        _searchResults.clear();
      });
    }
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
      genres: json['genres']
    );
  }
}

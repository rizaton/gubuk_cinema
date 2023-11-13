import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  static String tag = 'search-page';
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class Movie {
  final String title;
  final String posterPath;
  final double rating;
  final int ratingVote;
  final List<String> genres;

  Movie({required this.title,required this.posterPath,required this.genres, required this.rating, required this.ratingVote});
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      posterPath: json['poster_path'],
      genres: List<String>.from(
        json['genres']?.map((genre) => genre['name']) ?? [],
      ),
      rating: json['vote_average'],
      ratingVote: json['vote_count']
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String posterPath;
  final double rating;
  final int ratingVote;
  final List<String> genres;

  const MovieCard({required this.title,required this.posterPath,required this.genres, required this.rating, required this.ratingVote});

  @override
  Widget build(BuildContext context) {
    return 
      Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            print('kepencet');
          },
          child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //   Container(
          //     height: 300, // Sesuaikan tinggi gambar poster
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
          //       image: DecorationImage(
          //         image: NetworkImage(
          //             '$posterPath'),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          //         SizedBox(height: 4.0),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Container(
          //               width: 100,
          //               child: 
          //               Text(
          //                 genres.join(', '),
          //                 style: TextStyle(color: Colors.grey, fontSize: 11),
          //               ),
          //             ),
          //             Row(
          //               children: [
          //                 Icon(Icons.star, color: Colors.yellow),
          //                 SizedBox(width: 2.0),
          //                 Text(
          //                   '$rating',
          //                   style: TextStyle(color: Colors.black, fontSize: 10),
          //                 ),
          //                 Text('/ $ratingVote', style: TextStyle(color: Colors.grey, fontSize: 8))
          //               ],
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ],


            children: [
              Flexible(
                flex: 5,
                child: 
                Image.network(
                  '${posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                flex: 1,
                child: 
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            child: 
                            Text(
                              genres.join(', '),
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              SizedBox(width: 2.0),
                              Text(
                                '$rating',
                                style: TextStyle(color: Colors.black, fontSize: 11),
                              ),
                              Column(
                                children: [
                                  Text('/ $ratingVote', style: TextStyle(color: Colors.grey, fontSize: 9))
                                ]
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              )
            ],
          
          ),
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Flexible(
        //       flex: 5,
        //       child: Image.network(
        //         posterPath,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     Flexible(
        //       flex: 1,
        //       child: Container(
        //         color: Colors.white,
        //         child: ListTile(
        //           title: Text(title,
        //               style: const TextStyle(color: Colors.black)),
        //           subtitle: Text('$rating',
        //               style: const TextStyle(color: Colors.black)),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
    );
  }
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchControl = TextEditingController();
  Timer? delay;
  List<Movie> movieList = [];
  bool _isLoading = false;

  Future<void> _searchMovies(String query) async {
    
    if (query == '') {
      setState(() {
        movieList = [];
      });
    } else {
      setState(() {
        _isLoading = true;
      });
      final response = await http.get(
        // Uri.parse('$baseUrl?query=$query&api_key=$apiKey'),
        Uri.parse('https://gubukcinema.vercel.app/api/movies?title=$query'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // final List<dynamic> results = data['results'];
        // final List<dynamic> results = data as List;
        setState(() {
          movieList = data.map((movie) => Movie.fromJson(movie)).toList();
          print(movieList[0].title);
          print(movieList[0].posterPath);
          print(movieList[0].genres);
          print(movieList[0].rating);
          print(movieList[0].ratingVote);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load movies');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchControl,
          onChanged: (query) {
                if (delay?.isActive ?? false) delay?.cancel();
                delay = Timer(const Duration(milliseconds: 500), () {
                  // _searchMovies(searchControl.text);
                  _searchMovies(query);
                });
              },
          cursorColor: Colors.indigoAccent,
          decoration: const InputDecoration(
            labelText: 'Cari Film',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(60),
        //   child: Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: TextField(
        //       decoration: InputDecoration(
        //         hintText: 'Cari Film',
        //         prefixIcon: Icon(Icons.search),
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //         ),
        //       ),
        //       onChanged: (value) {
        //         // Tambahkan logika pencarian di sini (misalnya dengan memfilter daftar film)
        //       },
        //     ),
        //   ),
        // )
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) :
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.5,
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index) {
          // final mov = movieList[index];
          // return MovieCard(title: movieList[index]);
          return Padding(
            padding: EdgeInsets.all(8.0),
            child:
            MovieCard(
              title: movieList[index].title,
              posterPath: movieList[index].posterPath,
              genres: movieList[index].genres,
              rating: movieList[index].rating,
              ratingVote: movieList[index].ratingVote,
            )
            // Image.asset("../lib/assets/indigo.jpg", fit: BoxFit.contain)
            // MovieCard(title: mov["title"], imgPath: mov["poster_path"], genres: mov["genres"])
          );
        },
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gubuk_cinema/models/http_api.dart';
import 'package:gubuk_cinema/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverviewMovie extends StatefulWidget {
  final String idMovieDatabase;
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
    required this.idMovieDatabase,
  });

  @override
  State<OverviewMovie> createState() => _OverviewMovieState();
}

class _OverviewMovieState extends State<OverviewMovie> {
  String status = 'no_data';
  late bool buttonEnabled;

  @override
  void initState(){
    super.initState();
    buttonEnabled = false;
    _statusLogged();
  }

  Future<void> _statusLogged() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getStringList('bookmark')!).contains(widget.idMovieDatabase)) {
      setState(() {
        buttonEnabled = false;
      });
    } else {
      setState(() {
        buttonEnabled = true;
      });
    }
    if (prefs.get('logged') == 'true') {
      setState(() {
        status = 'logged';
      });
    }
  }

  Future<void> _addBook(movieDatabaseID) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookData = prefs.getStringList('bookmark')!;

    if (bookData.contains(movieDatabaseID)) {
      // ignore: use_build_context_synchronously
      _showToast(context, 'Data buku sudah ada dalam bookmark anda');
      setState(() {
        buttonEnabled = false;
      });

    } else if (!bookData.contains(movieDatabaseID)){
      // ignore: use_build_context_synchronously
      _showToast(context, 'Data berhasil ditambahkan kedalam bookmark');

      bookData.add(movieDatabaseID);

      final String userIDlog = prefs.getStringList('user')![0];
      final String fullname = prefs.getStringList('user')![1];
      final String username = prefs.getStringList('user')![2];
      final String password = prefs.getStringList('user')![3];
      final String email = prefs.getStringList('user')![4];

      final paramsIDUser = {
        'id': userIDlog,
      };

      final Map<String, dynamic> userData = {
        'username': username,
        'fullname': fullname,
        'email': email,
        'password': password,
        'bookmark': bookData,
      };
      final String jsonData = jsonEncode(userData);
      await postAPIAccountUpdate(jsonData, paramsIDUser);
      await prefs.setStringList('bookmark',bookData);
      setState(() {
        buttonEnabled = false;
      });
      // ignore: use_build_context_synchronously
      build(context);
    } else {
      // ignore: use_build_context_synchronously
      _showToast(context, 'Terjadi kesalahan');
    }
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
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
                  shape: BoxShape.circle, color: Color.fromARGB(64, 0, 0, 0)),
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
                            right: 5),
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ),
                      Text(
                        '${widget.ratingMovie} |  ',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 5),
                        child: Icon(
                          Icons.people,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${widget.popularityMovie}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.overviewMovie),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: List.generate(
                          widget.genreMovie.length,
                          (index) => Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
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
                  ),
                  ElevatedButton(
                    onPressed: buttonEnabled? () {
                      if (status == 'logged') {
                        _addBook(widget.idMovieDatabase);
                      } else if (status == 'no_data'){
                        _showToast(context, 'Silahkan melakukan login terlebih dahulu');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage()
                            )
                        );
                      } else {
                        _showToast(context, 'Telah terjadi kesalahan');
                      }
                      
                    } : null,
                    style: ElevatedButton.styleFrom(
                      
                      foregroundColor: Colors.white, backgroundColor: Colors.black,
                      padding:
                          const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            6),
                      ),
                    ),
                    child: const SizedBox(
                      width:
                          500,
                      child: Center(
                        child: Text('Bookmark', textAlign: TextAlign.center),
                      ),
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
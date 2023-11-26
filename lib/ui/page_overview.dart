import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gubuk_cinema/models/http_api.dart';
import 'package:gubuk_cinema/tools/future_tools.dart';
import 'package:gubuk_cinema/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageOverview extends StatefulWidget {
  final String idMovie;

  const PageOverview({
    super.key,
    required this.idMovie,
  });

  @override
  State<PageOverview> createState() => _PageOverviewState();
}

class _PageOverviewState extends State<PageOverview> {
  String status = 'false'; 
  late bool _isLoading;
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getData();
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _getData() async {
    var prefs = await SharedPreferences.getInstance();

    bool login = await FutureTools().checkLogin()?? false;
    if (login) {
      setState(() {
        status = 'logged';
      });
      var bookmarkList = prefs.getStringList('bookmark_id')?? [];
      // ignore: iterable_contains_unrelated_type
      if (bookmarkList.contains(widget.idMovie)) {
        setState(() {
          _isEnabled = false;
        });
      }
      setState(() {
        _isEnabled = true;
      });
    } else {
      setState(() {
        _isEnabled = true;
        _isLoading = false;
      });
    }
  }

  Future<void> _addBook(String movieID) async {
    setState(() {
      _isLoading = true;
    });
    var prefs = await SharedPreferences.getInstance();

    final idUser = prefs.getStringList('user')?[0];
    List<String>? bookmarkList = prefs.getStringList('bookmark_movie');
    bookmarkList?.add(movieID);

    final Map<String, dynamic> queryParameters = {
      "id_user": idUser,
    };
    final Map<String, dynamic> body = {
      'bookmark_movie': bookmarkList,
    };
    postBookmark(jsonEncode(body), queryParameters);
    // ignore: use_build_context_synchronously
    _showToast(context, 'Data buku berhasil ditambahkan');
    setState(() {
      _isLoading = false;
      _isEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FutureTools().fetchMovie(widget.idMovie,''),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                      snapshot.data![14],
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
                              snapshot.data![3],
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10, right: 5),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ),
                            Text(
                              '${snapshot.data![5]} |  ',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10, right: 5),
                              child: Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              snapshot.data![7],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(snapshot.data![4]),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(
                                snapshot.data![12].split('_').length,
                                (index) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    snapshot.data![12].split('_')[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        _isLoading
                        ? const Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                          onPressed: _isEnabled ? () {
                            if (status == 'logged') {
                              _addBook(snapshot.data![1]);
                            } else if (status == 'false'){
                              _showToast(context, 'Silahkan melakukan login terlebih dahulu');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login()
                                  )
                              );
                            } else {
                              _showToast(context, 'Telah terjadi kesalahan');
                            }
                            
                          }:null,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const SizedBox(
                            width: 500,
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
        return const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}

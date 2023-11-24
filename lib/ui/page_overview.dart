import 'package:flutter/material.dart';
import 'package:gubuk_cinema/tools/future_tools.dart';
import 'package:gubuk_cinema/ui/login_page.dart';

class PageOverview extends StatefulWidget {
  final int indexMovie;

  const PageOverview({
    super.key,
    required this.indexMovie,
  });

  @override
  State<PageOverview> createState() => _PageOverviewState();
}

class _PageOverviewState extends State<PageOverview> {
  String status = 'false'; 
  bool _isLoading = true;
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
  
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _addBook(String movieID) async {

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FutureTools().fetchMovie(widget.indexMovie),
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
                              _addBook(snapshot.data![2]);
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

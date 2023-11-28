import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gubuk_cinema/tools/future_tools.dart';
import 'package:gubuk_cinema/ui/page_overview.dart';
import 'package:gubuk_cinema/ui/page_search.dart';
import 'package:gubuk_cinema/widget/drawer.dart';

import 'package:shared_preferences/shared_preferences.dart';


class PageHome extends StatefulWidget {
  
  const PageHome({super.key,});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  late int lenMovies;
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    _isLoading = true;
    _getLenMovie();
  }
  
  @override
  Widget build(BuildContext context) {
    final int currentCount = (MediaQuery.of(context).size.width ~/ 250).toInt();
    const int minCount = 2;
    
    TextEditingController searchMovieController = TextEditingController();

    return _isLoading?
    const Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    )
    : Scaffold (
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
                  color: Colors.white,
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
                          controller: searchMovieController,
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
                          _searchMovie(searchMovieController.text);
                        },
                        child: const Text('Cari'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,
          ),SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisSpacing: 4.0,
              // mainAxisSpacing: 4.0,
              // childAspectRatio: 0.5,
              // crossAxisCount: 2,
              crossAxisCount: max(currentCount, minCount),
              childAspectRatio: 0.5,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _Card(index);
              },
              childCount: lenMovies,
            ),
          ),
        ],
      ),
      drawer: const DrawerSide(),
    );
  }
  Future<void> _getLenMovie() async{
    var prefs = await SharedPreferences.getInstance();
    List<String> lenMovie = prefs.getStringList('moviedb_id')??[];
    setState(() {
      lenMovies = lenMovie.length;
      _isLoading = false;
    });
  }

  void _searchMovie (String text){
    String textSearch = text;
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => PageSearch(searchTextQuery: textSearch)
      )
    );
  }
}

class _Card extends StatelessWidget {
  final int indexMovie;
  const _Card(this.indexMovie);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FutureTools().fetchMovie('','$indexMovie'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return InkWell(
            borderRadius:
                const BorderRadius.all(Radius.circular(3)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageOverview(idMovie: snapshot.data![1])
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 5,
                  child: Image.network(
                    snapshot.data![14],
                    fit: BoxFit.cover,
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
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Failed to load Image');
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(snapshot.data![3],
                          style:
                              const TextStyle(color: Colors.black)),
                      subtitle: Text(
                          'Popularity: ${snapshot.data![7]}',
                          style:
                              const TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(color: Colors.black),
        );
      }
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

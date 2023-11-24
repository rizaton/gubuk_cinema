import 'package:flutter/material.dart';
import 'package:gubuk_cinema/tools/future_tools.dart';
import 'package:gubuk_cinema/ui/page_overview.dart';
import 'package:gubuk_cinema/widget/drawer.dart';

class PageHome extends StatefulWidget {
  
  const PageHome({super.key,});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
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
                return _Card(index);
              },
              childCount: 14,
            ),
          ),
        ],
      ),
      drawer: const DrawerSide(),
    );
  }
}

class _Card extends StatelessWidget {
  final int indexMovie;
  const _Card(this.indexMovie);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FutureTools().fetchMovie(indexMovie),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return InkWell(
            borderRadius:
                const BorderRadius.all(Radius.circular(3)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageOverview(indexMovie: indexMovie)
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
          child: CircularProgressIndicator(),
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

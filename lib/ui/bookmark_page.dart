import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Page'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Expanded(
                child: BookmarkCard(
                  imageUrl: '../lib/assets/indigo.jpg',
                  title: 'Judul Film 1',
                  popularity: 'Popularity: 85%',
                ),
              ),
              Expanded(
                child: BookmarkCard(
                  imageUrl: '../lib/assets/indigo.jpg',
                  title: 'Judul Film 2',
                  popularity: 'Popularity: 92%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookmarkCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String popularity;

  BookmarkCard({
    required this.imageUrl,
    required this.title,
    required this.popularity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            height: 300.0,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5.0),
                Text(popularity),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    const Text("Edit", style: TextStyle(color: Colors.black)),
                    Padding(
                      padding: const EdgeInsets.only(left: 70.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (value) {},
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.black;
                              }
                              return Colors.black12;
                            }),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

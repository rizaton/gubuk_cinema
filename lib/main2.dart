import 'dart:convert';
import 'package:gubuk_cinema/models/http_api.dart';

void main(List<String> args) {
  Future<void> dataFetch() async {
    var uri = await getAPIMovies();
    List<dynamic> jsonData = json.decode(uri);
    for (var item in jsonData) {
      String name = item['poster_path'];
      print(name);
    }
  }
  dataFetch();
}
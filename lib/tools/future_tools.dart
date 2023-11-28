import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_api.dart';
import 'package:gubuk_cinema/models/movie_model.dart';

String prefsKey = 
'''
'user'
'bookmark_id'
'bookmark_movie'
'moviedb_id'
'logged'
'movie_\${index}'

"0_key 1_idMovieDb 2_movieID 3_title 4_overview 5_rating 6_voteCount 7_popularity 8_releseDate 9_status 10_budget 11_revenue 12_genres 13_runtime 14_posterPath"
''';


class FutureTools {
  Future<void> resetData()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user', [
      '_ids',
      'unam',
      'name',
      'mail',
      'pass',
    ]);
    await prefs.setString('bookmark_id', '');
    await prefs.setStringList('bookmark_movie', []);
    await prefs.setBool('login', false);
  }

  Future<List<String>> fetchMovie(
    String? idMovie, String? index
    ) async {
    var prefs = await SharedPreferences.getInstance();
    if ('' != idMovie) {
      List<String>? idMovieList = prefs.getStringList('moviedb_id');
      var indexMovie = idMovieList!.indexOf(idMovie!);
      List<String> data = prefs.getStringList('movie_$indexMovie')??[];
      return data;
    } else if ('null' != index){
      List<String> data = prefs.getStringList('movie_$index')??[];
      return data;
    } else {
      return [];
    }
  }

  Future<bool?> checkLogin() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('login');
  }

  Future<String> dataFetch() async {
    var uri = await getMovies();
    List<dynamic> jsonData = json.decode(uri);

    List<MovieModels> dataMovie = jsonData.map(
        (e) => MovieModels.fromJson(e)
      ).toList();
    
    var prefs = await SharedPreferences.getInstance();
    List<String> moviedbID = [];
    int index = 0;
    for (var element in dataMovie) {
      moviedbID.add(element.idMovieDb);
      await prefs.setStringList('movie_$index', 
      [ "0_key 1_idMovieDb 2_movieID 3_title 4_overview 5_rating 6_voteCount 7_popularity 8_releseDate 9_status 10_budget 11_revenue 12_genres 13_runtime 14_posterPath",
        element.idMovieDb,
        element.movieID,
          element.title,
          element.overview,
        element.rating,
        element.voteCount,
        element.popularity,
          element.releseDate,
          element.status,
        element.budget,
        element.revenue,
          element.genres,
          element.runtime,
          element.posterPath,
      ]);
      index++;
    }
    await prefs.setStringList('moviedb_id', moviedbID);
    return "success";
  }
}
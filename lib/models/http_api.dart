import 'package:gubuk_cinema/models/env.dart';
import 'package:http/http.dart' as http;

Future<String> getMovies() async {
  try {
    final response = await http.get(Uri.https(envAPI(),'/api/movies'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> findMovie(params) async {
  try {
    final response = await http.get(Uri.https(envAPI(),'/api/movies',params));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<http.Response> getBookmark(params) async {
  try {
    final response = await http.get(Uri.https(envAPI(),'/api/bookmark',params));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<http.Response> loginAccount(String body) async {
  try {
    final response = await http.post(Uri.https(envAPI(),'/api/login'), body: body);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> registerAccount(String body) async {
  try {
    final response = await http.post(Uri.https(envAPI(),'/api/account'), body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> postBookmark(String body, params) async {
  try {
    final response = await http.post(Uri.https(envAPI(),'/api/movies',params), body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> accountUpdate(String body, params) async {
  var uri = Uri.https(
    envAPI(),
    '/api/update',
    params,
  );

  try {
    final response = await http.post(uri, body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

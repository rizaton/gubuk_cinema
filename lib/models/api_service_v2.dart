import 'package:gubuk_cinema/models/env.dart';
import 'package:http/http.dart' as http;

Future<http.Response> accountLogin(String bodyJson) async {
  try {
    final response =
        await http.post(Uri.https(envAPI(), '/api/v2/login'), body: bodyJson);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> getMovie() async {
  try {
    final response = await http.get(Uri.https(envAPI(), '/api/v2/movies'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> getFindMovie(Map<String, dynamic> queryParameter) async {
  try {
    final response =
        await http.get(Uri.https(envAPI(), '/api/v2/movies', queryParameter));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> postRegister(String bodyJson) async {
  try {
    final response =
        await http.post(Uri.https(envAPI(), '/api/account'), body: bodyJson);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<http.Response> findBookmark(Map<String, dynamic> queryParameter) async {
  try {
    final response =
        await http.get(Uri.https(envAPI(), '/api/bookmark', queryParameter));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> postBookmark(
    String bodyJson, Map<String, dynamic> queryParameter) async {
  try {
    final response = await http.post(
        Uri.https(envAPI(), '/api/v2/bookmark', queryParameter),
        body: bodyJson);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> postAccount(String bodyJson) async {
  try {
    var uri = Uri.https(envAPI(), '/api/v2/update');
    final response = await http.post(uri, body: bodyJson);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

Future<String> deleteAccount(String bodyJson) async {
  try {
    var uri = Uri.https(envAPI(), '/api/v2/update');
    final response = await http.delete(uri, body: bodyJson);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to make the request: $e');
  }
}

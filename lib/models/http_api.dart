import 'package:http/http.dart' as http;
getAPIAccount() {
  var uri = Uri.https('gubukcinema.vercel.app', '/api/account');
  dataReturn() async {
    final response = await http.get(
      uri,
      );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
  return dataReturn();
}
getAPIMovies() {
  var uri = Uri.https('gubukcinema.vercel.app', '/api/movies');
  dataReturn() async {
    final response = await http.get(
      uri,
      );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
  return dataReturn();
}

postAPIAccount(String body) {
  var uri = Uri.https('gubukcinema.vercel.app', '/api/account'); //'/api/account'
  dataReturn() async {
    final response = await http.post(
      uri,
      body: body,
      );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
  return dataReturn();
}
postAPIMovies(String body) {
  var uri = Uri.https('gubukcinema.vercel.app', '/api/movies'); //'/api/account'
  dataReturn() async {
    final response = await http.post(
      uri,
      body: body,
      );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
  return dataReturn();
}
putAPIAccount(String body) {
  var uri = Uri.https('gubukcinema.vercel.app', '/api/account');
  dataReturn() async {
    final response = await http.put(
      uri,
      body: body,
      );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
  return dataReturn();
}

import 'package:gubuk_cinema/models/env.dart';
import 'package:http/http.dart' as http;

getAPIAccount() {
  var uri = Uri.https(
    envAPI('acc')[0],
    envAPI('acc')[1]
    );
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
  var uri = Uri.https(
    envAPI('mov')[0],
    envAPI('mov')[1]
  );
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
  var uri = Uri.https(
    envAPI('acc')[0],
    envAPI('acc')[1]
    ); //'/api/account'
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
  var uri = Uri.https(
    envAPI('mov')[0],
    envAPI('mov')[1]
    );
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
  var uri = Uri.https(
    envAPI('acc')[0],
    envAPI('acc')[1]
    );
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

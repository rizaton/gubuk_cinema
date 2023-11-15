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
postAPIMovies(String body) {
  var uri = Uri.https(
    envAPI('movup')[0],
    envAPI('movup')[1]
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
postAPIAccountUpdate(String body, params){
  var uri = Uri.https(
    envAPI('accup')[0],
    envAPI('accup')[1],
    params
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
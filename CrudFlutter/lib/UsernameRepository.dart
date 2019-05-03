import 'dart:io';
import 'dart:convert';
import 'User.dart';
import 'package:http/http.dart' as http;

class UsernameRepository {

  Future<List<User>> fetchUsers() async {
    final response =
    await http.get('https://hlocaqwby5.execute-api.us-east-1.amazonaws.com/dev/items');

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<User> users = [];
      for (var user in data) {
        users.add(User.fromJson(user));
      }
      return users;
    } else {
      throw Exception('Failed to load user list');
    }
  }

  Future<User> postUser(String name) async {
    User user = User(id:0, name:name);
    var data = json.encode(user.toJson());
    var url = 'https://hlocaqwby5.execute-api.us-east-1.amazonaws.com/dev/items';
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonUser = json.decode(response.body);
      return User.fromJson(jsonUser);
    }
    else {
      throw Exception("Failed to create user" + response.statusCode.toString());
    }
  }

  Future<User> editUser(User user) async {
    var data = json.encode(user.toJson());
    var url = 'https://hlocaqwby5.execute-api.us-east-1.amazonaws.com/dev/items';
    var response = await http.put(url, body: data);
    if (response.statusCode == 200) {
      var jsonUser = json.decode(response.body);
      return User.fromJson(jsonUser);
    }
    else {
      throw Exception("Failed to create user" + response.statusCode.toString());
    }
  }

  void deleteUser(User user) async {
    final response =
    await http.delete('https://hlocaqwby5.execute-api.us-east-1.amazonaws.com/dev/items/' + user.id.toString());

    if (response.statusCode != 200) {
      throw Exception("Unable to delete user " + user.name);
    }
  }


}


void main() async {

  var repo = UsernameRepository();

  var result = await repo.postUser("Mr. Slate");
  print(result);

}
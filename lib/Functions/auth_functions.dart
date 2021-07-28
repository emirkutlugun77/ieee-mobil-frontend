import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/user.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future loginUser(String email, String password) async {
  var response = await http.post(Uri.parse(baseUri + 'v1/auth/login'),
      body: {'email': email, 'password': password});
  if (response.statusCode == 400) {
    print('err');
  } else {
    var decodedData = jsonDecode(response.body);
    var id = decodedData['userId'];
    getUser(id);

    User user = await getUser(id);
    return user;
  }
}

Future getUser(String id) async {
  var response = await http.get(Uri.parse(baseUri + 'v1/users/$id'));
  if (response.statusCode == 400) {
    print('err');
  } else {
    var decodedData = jsonDecode(response.body);

    return User.fromJson(decodedData['user']);
  }
}

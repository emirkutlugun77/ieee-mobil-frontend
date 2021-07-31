import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/user.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getAllPosts() async {
  var response = await http.get(Uri.parse(baseUri + 'v1/post/'));
  print(response.body);
}

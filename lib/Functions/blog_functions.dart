import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/commitee.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future<dynamic> mostViewed() async {
  var response =
      await http.get(Uri.parse(baseUri + 'v1/blog-post/most-viewed'));
}

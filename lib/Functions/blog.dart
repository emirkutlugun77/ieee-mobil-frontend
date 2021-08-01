import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/blogposts.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getMost5(List<BlogPost> blogPosts) async {
  var response =
      await http.get(Uri.parse(baseUri + 'v1/blog-post/most-viewed'));

  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);

    decodedData['mostViewedBlogPosts'].forEach((e) async {
      var singleResponse =
          await http.get(Uri.parse(baseUri + 'v1/blog-post/${e['slug']}'));

      blogPosts
          .add(BlogPost.fromJson(jsonDecode(singleResponse.body)['blogPost']));
    });

    return blogPosts;
  } else {
    return 'error';
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/blogposts.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getMost5(List<BlogPost> blogPosts) async {
  var response =
      await http.get(Uri.parse(baseUri + 'v1/blog-post/most-viewed'));

  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    print(decodedData['mostViewedBlogPosts'].length); // always print 5
    decodedData['mostViewedBlogPosts'].forEach((e) async {
      await http.get(Uri.parse(baseUri + 'v1/blog-post/${e['slug']}')).then(
          (value) => blogPosts
              .add(BlogPost.fromJson(jsonDecode(value.body)['blogPost'])));
    });
  } else {
    return 'error';
  }
}

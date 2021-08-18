import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/blogposts.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getMost5(List<BlogPost> blogPosts, String token, int page) async {
  var response = await http.get(
      Uri.parse(baseUri + 'v1/blog-post?size=6&page=$page'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);

    decodedData['blogPosts'].forEach((e) async {
      blogPosts.add(BlogPost.fromJson(e));
    });
  } else {
    return 'error';
  }
}

Future<bool> likeBlog(bool isLiked, String token, BlogPost post) async {
  if (isLiked) {
    post.likeCount--;
    await http.put(Uri.parse(baseUri + 'v1/blog-post/${post.id}/unlike/'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    print('working');
  } else {
    post.likeCount++;
    await http.put(Uri.parse(baseUri + 'v1/blog-post/${post.id}/like'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    print('working');
  }

  return !isLiked;
}

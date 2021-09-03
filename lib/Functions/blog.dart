import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/blogposts.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getMost5(List<BlogPost> blogPosts, String token, int page) async {
// api dan cevap alma
  var response = await http.get(
      Uri.parse(baseUri + 'v1/blog-post?size=6&page=$page'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
// api dan cevap alma burdaki header kısmı her apida farklı olabilir
  if (response.statusCode == 200) {
    // yaptığım api request başarılı olduysa statusCode 200 olur
    var decodedData = jsonDecode(response.body);
    //üstteki satırda aldığım dönütü JSON formatına çeviriyorum
    decodedData['blogPosts'].forEach((e) async {
      blogPosts.add(BlogPost.fromJson(e));
    });
    //json formatına bağlı olarak tek tek her data parçasını client side kısmında yazdığım modeller yardımıyla çevirip kendime alıyorum
    //örnek modeller için models klasörüen bak
    //burdaki kullanım pek doğru değil sen istersen return blogPosts da yazabilirsin
  } else {
    return 'error';
  }
}

Future<bool> likeBlog(bool isLiked, String token, BlogPost post) async {
  if (isLiked) {
    post.likeCount--;
    await http.put(Uri.parse(baseUri + 'v1/blog-post/${post.id}/unlike/'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  } else {
    post.likeCount++;
    await http.put(Uri.parse(baseUri + 'v1/blog-post/${post.id}/like'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  }

  return !isLiked;
}

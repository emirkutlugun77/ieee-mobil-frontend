import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:my_app/UI/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getAllPosts(List<Post> posts) async {
  String token;
  print('aaa');
  var prefs = await SharedPreferences.getInstance();
  token = (prefs.getString('token'))!;
  var response = await http.get(Uri.parse(baseUri + 'v1/post/'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  var decodedData = jsonDecode(response.body);
  decodedData['posts'].forEach((post) => posts.add(Post.fromJson(post)));
  return posts;
}

Future<bool> onLikeButtonTapped(bool isLiked, Post post, String token) async {
  if (isLiked) {
    post.likeCount--;
    await http.put(Uri.parse(baseUri + 'v1/post/${post.id}/unlike'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  } else {
    post.likeCount++;
    await http.put(Uri.parse(baseUri + 'v1/post/${post.id}/like'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  }

  print('working');
  return !isLiked;
}

Future writePost(
  File? image,
  String text,
  String token,
) async {
  var formData = FormData.fromMap({
    'text': text,
    'photo': image != null ? await MultipartFile.fromFile(image.path) : null
  });
  var response = await Dio().post(
      'https://ancient-falls-28306.herokuapp.com/v1/post',
      data: formData,
      options:
          Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));

  return response.data['post']['_doc'];
}

Future deletePost(String id, String token) async {
  try {
    await http.delete(Uri.parse(baseUri + 'v1/post/$id'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    print('post silindi');
    return 'Post Silindi';
  } catch (e) {
    return 'Post Silinirken Hata';
  }
}

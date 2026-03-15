import 'dart:convert';
import 'package:firstscreenapi/model/post_model.dart';
import 'package:http/http.dart' as http;

class HttpHelper {

  Future<List<PostModel>> getPosts() async {

    final response = await http.get(
      Uri.parse('https://dummyjson.com/posts'),
    );

    final data = jsonDecode(response.body);

    List posts = data['posts'];

    return posts.map((e) => PostModel.fromJson(e)).toList();
  }
}
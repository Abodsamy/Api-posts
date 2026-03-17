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

  Future<PostModel?> addPost(PostModel post) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/posts/add'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return PostModel.fromJson(data);
    } else {
      return null;
    }
  }
}

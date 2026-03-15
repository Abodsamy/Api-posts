import 'package:firstscreenapi/http_helper.dart';
import 'package:firstscreenapi/model/post_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> posts = [];

  void getData() async {
    final data = await HttpHelper().getPosts();

    setState(() {
      posts = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(posts[index].title),
              subtitle: Text(posts[index].body),
            ),
          );
        },
      ),
    );
  }
}

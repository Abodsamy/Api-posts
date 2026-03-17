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

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final data = await HttpHelper().getPosts();

    setState(() {
      posts = data;
    });
  }

  void addNewPost() async {
    PostModel newPost = PostModel(
      id: 0,
      title: "New Post",
      body: "This is a new post",
    );

    final result = await HttpHelper().addPost(newPost);

    if (result != null) {
      setState(() {
        posts.insert(0, result);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post Added ")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed ")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addNewPost,
          ),
        ],
      ),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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

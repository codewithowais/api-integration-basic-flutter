import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapi/models/post_model.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<PostModel>> getPosts() async {
    List<PostModel> list = [];
    var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    for (var singleMap in responseBody) {
      list.add(PostModel.fromJson(singleMap));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPosts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
          return Container(
            margin: EdgeInsets.only(top: 5),
            child: ListTile(
              tileColor: Colors.grey,
              title: Text(snapshot.data?[1].title ?? "empty title"),
              subtitle: Text(snapshot.data?[1].id.toString() ?? "empty id"),
            ),
          );
        },
      ),
    );
  }
}

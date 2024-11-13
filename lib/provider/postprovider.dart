import 'dart:convert';
import 'dart:developer';

import 'package:crud_demo/model/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Postprovider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  // Get post
  Future<void> fetchPosts() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/api/items/"));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      _posts = data.map((item) => Post.fromJson(item)).toList();
      print(_posts);
      notifyListeners();
    } else {
      log("fetchPosts Method Call but data not get...! ");
    }
  }

  // Add Post
  Future<void> addPost(Post post) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/items/'), // Django backend URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );
    print(response);
    if (response.statusCode == 201) {
      // Server se response successfully aane par
      _posts.add(Post.fromJson(json.decode(response.body)));
      print(_posts);
      notifyListeners();
    } else {
      log("Failed to add post: ${response.statusCode}");
    }
  }

//delete provider
  Future<void> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse(
          'http://10.0.2.2:8000/api/items/$id/'), // ID ko URL mein include karna hoga
    );

    if (response.statusCode == 204) {
      // Successfully deleted
      print("Post deleted successfully!");
      notifyListeners();
    } else {
      log("Failed to delete post: ${response.statusCode}");
    }
  }

  // Update Post (PUT)
  Future<void> updatePost(int id, Post post) async {
    final response = await http.put(
      Uri.parse(
          'http://10.0.2.2:8000/api/items/$id/'), // ID ko URL mein include karna hoga
      headers: {'Content-Type': 'application/json'},
      body:
          json.encode(post.toJson()), // Update data ko JSON format mein bhejna
    );

    if (response.statusCode == 200) {
      // Successfully updated
      print("Post updated successfully!");

      // Update the post in the local list
      int index = _posts.indexWhere((existingPost) => existingPost.id == id);
      if (index != -1) {
        _posts[index] = post; // Replace with updated post
        notifyListeners();
      }
    } else {
      log("Failed to update post: ${response.statusCode}");
    }
  }
}

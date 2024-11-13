import 'dart:developer';

import 'package:crud_demo/model/post.dart';
import 'package:crud_demo/provider/postprovider.dart';
import 'package:crud_demo/screen/postlistscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Insertdata extends StatefulWidget {
  final Post? post;
  const Insertdata({super.key, this.post});

  @override
  State<Insertdata> createState() => _InsertdataState();
}

class _InsertdataState extends State<Insertdata> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _titleController.text = widget.post!.name;
      _bodyController.text = widget.post!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String body = _bodyController.text;

      log("Title => $title");
      log("Body => $body");

      // Post object banayein
      if (widget.post == null) {
        Post newPost = Post(
            id: 0,
            name: title,
            description: body); // id=0 kyunki server id auto-generate karega

        // Add post ko Postprovider ke through call karein
        Provider.of<Postprovider>(context, listen: false).addPost(newPost);
      } else {
        Post updatePost =
            Post(id: widget.post!.id, name: title, description: body);
        Provider.of<Postprovider>(context, listen: false)
            .updatePost(widget.post!.id, updatePost);
      }
      setState(() {
        _titleController.clear();
        _bodyController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? "Insert Data" : "Update"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter A Title";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _bodyController,
                  decoration: const InputDecoration(
                    labelText: "Body",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter A Body";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _submitData();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Postlistscreen()));
                        },
                        child: Text(widget.post == null ? "Submit" : "Update"))
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

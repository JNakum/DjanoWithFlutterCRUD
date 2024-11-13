import 'dart:math';
import 'package:crud_demo/provider/postprovider.dart';
import 'package:crud_demo/screen/insertdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Postlistscreen extends StatefulWidget {
  const Postlistscreen({super.key});

  @override
  State<Postlistscreen> createState() => _PostlistscreenState();
}

class _PostlistscreenState extends State<Postlistscreen> {
  final Random _random = Random(); // Random instance for generating colors

  // Color options list
  final List<Color> _colors = [
    Colors.lightBlue[100]!,
    Colors.lightGreen[100]!,
    Colors.pink[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.yellow[100]!,
    Colors.teal[100]!,
  ];

  @override
  void initState() {
    super.initState();
    // Screen load hote hi data fetch karne ke liye fetchPosts call karein
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Postprovider>(context, listen: false).fetchPosts();
    });
  }

  // Method to get a random color from _colors list
  Color _getRandomColor() {
    return _colors[_random.nextInt(_colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<Postprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display Data"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  postProvider.fetchPosts(); // Refresh button se data reload
                },
                icon: const Icon(Icons.refresh),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Insertdata(),
                    ),
                  );
                },
                icon: const Icon(Icons.insert_drive_file),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<Postprovider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.posts.length,
            itemBuilder: (context, index) {
              final post = provider.posts[index];
              return Card(
                color: _getRandomColor(), // Random color for each card
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Id: ${post.id}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Title: ${post.name}",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 8, 38, 63),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Body: ${post.description}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Insertdata(
                                    post: post,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.blue),
                          ),
                          IconButton(
                            onPressed: () async {
                              await provider.deletePost(post.id);
                              await provider
                                  .fetchPosts(); // Deletion ke baad data reload
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const Insertdata(),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

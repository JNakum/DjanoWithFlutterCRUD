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
  @override
  void initState() {
    super.initState();
    // Screen load hote hi data fetch karne ke liye fetchPosts call karein
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Postprovider>(context, listen: false).fetchPosts();
    });
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
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Insertdata(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.insert_drive_file))
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
              return ListTile(
                title: Text(
                  "Id :- ${post.id}  \nTitle :- ${post.name}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.deepOrange,
                  ),
                ),
                subtitle: Text(
                  "Body :- ${post.description}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.teal,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
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
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        await provider.deletePost(post.id);
                        await provider
                            .fetchPosts(); // Deletion ke baad data reload
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
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

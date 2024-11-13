class Post {
  final int id;
  final String name;
  final String description;

  Post({required this.id, required this.name, required this.description});

  //  JSON to object
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json["id"], name: json["name"], description: json["description"]);
  }

  // object to JSON
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "description": description};
  }
}

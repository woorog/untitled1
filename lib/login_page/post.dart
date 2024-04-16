class Post {
  String userId;
  String title;
  String contents;

  Post({
    required this.userId,
    required this.title,
    required this.contents,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    userId: json["userId"],
    title: json["title"],
    contents: json["contents"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "title": title,
    "contents": contents,
  };
}

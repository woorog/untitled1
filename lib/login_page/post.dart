class Post {
  String userId;
  String title;
  String comment;
  String contents;

  Post({
    required this.userId,
    required this.title,
    required this.comment,
    required this.contents,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    userId: json["userId"],
    title: json["title"],
    comment: json["comment"],
    contents: json["contents"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "title": title,
    "comment": comment,
    "contents": contents,
  };
}

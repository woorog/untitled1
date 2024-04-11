class Post {
  String userid;
  String title;
  String contents;

  Post({required this.userid, required this.title, required this.contents});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userid: json['userId'] as String,
      title: json['title'] as String,
      contents: json['contents'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userid,
      'title': title,
      'contents': contents,
    };
  }
}

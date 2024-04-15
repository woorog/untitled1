import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../login_page/post.dart';

class CreateModel {
  Future<void> uploadPost(String title, String contents) async {
    final postsRef =
        FirebaseFirestore.instance.collection('post').withConverter<Post>(
              fromFirestore: (snapshot, _) => Post.fromJson((snapshot.data()!)),
              toFirestore: (post, _) => post.toJson(),
            );

    postsRef.add(
      Post(userId: FirebaseAuth.instance.currentUser?.uid ?? '', title: title, contents: contents, comment: '')
    );
  }
}

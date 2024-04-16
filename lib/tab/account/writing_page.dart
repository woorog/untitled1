import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore 추가
import 'package:untitled1/login_page/post.dart';

class New extends StatelessWidget {
  const New({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentsController = TextEditingController();

    void uploadPost() {
      String title = titleController.text;
      String contents = contentsController.text;

      final FirebaseAuth auth = FirebaseAuth.instance; //   유저 정보 가져오기
      String userid = auth.currentUser!.uid;

      Post newPost =
          Post(title: title, contents: contents, userId: userid);
      // Post 객체를 Firestore에 업로드

      FirebaseFirestore.instance
          .collection('posts')
          .add(newPost.toJson())
          .then((value) {
        print('Post uploaded successfully!');
      }).catchError((error) {
        // 업로드 실패 시 작업 수행
        print('Failed to upload post: $error');
      });
      titleController.clear();
      contentsController.clear();
      // 보낸이후에 보드 비우기.
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        actions: [
          IconButton(
            onPressed: uploadPost, // 업로드 함수 호출
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "제목을 입력하세요",
                fillColor: Colors.white70,
              ),
            ),
            const SizedBox(height: 10), // 간격 조절
            Expanded(
              child: TextFormField(
                controller: contentsController,
                maxLines: 20, // 다수의 줄을 입력할 수 있도록 함
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "내용을 입력하세요",
                  fillColor: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String userId;
  final String contents;

  DetailPage({required this.title, required this.userId, required this.contents});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController commentController = TextEditingController();

  void submitComment() {
    String comment = commentController.text;
    //댓글 저장하는 코드
    FirebaseFirestore.instance.collection('comments').add({
      'postId': widget.title,
      'userId': widget.userId,
      'comment': comment,
      'timestamp': DateTime.now(),
    }).then((value) {
      // 댓글 제출 후 초기화
      commentController.clear();
    }).catchError((error) {
      //오류 처리
      print('Failed to submit comment: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${widget.title}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Contents: ${widget.contents}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: submitComment,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Comments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // 여기에 Firestore에서 댓글을 가져와서 화면에 표시하는 코드 추가
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                //'comments' 'postId' 같은친구 골라서 그 코멘트만 가져옴
                stream: FirebaseFirestore.instance.collection('comments').where('postId', isEqualTo: widget.title).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No comments yet'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot commentDoc = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(commentDoc['comment']),
                        subtitle: Text('By: ${commentDoc['userId']}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

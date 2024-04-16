import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String userId;
  final String contents;
  final String documentIds;
  DetailPage({required this.title, required this.userId, required this.contents, required this.documentIds});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController commentController = TextEditingController();

  void submitComment() {
    String comment = commentController.text;
    //댓글 저장하는 코드
    FirebaseFirestore.instance.collection('comments').add({
      'comment': comment,
      'userId':widget.userId,
      'docu_id':widget.documentIds
    }).then((value) {
      // 댓글 제출 후 초기화
      commentController.clear();
    }).catchError((error) {
      //오류 처리
      print('Failed to submit comment: $error');
    });
  }


  void deleteComment(String commentId) {
    // 해당 댓글 삭제
    FirebaseFirestore.instance.collection('comments').doc(commentId).delete().then((value) {
      print('Comment deleted successfully');
    }).catchError((error) {
      // 오류 처리
      print('Failed to delete comment: $error');
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
              'did: ${widget.documentIds}',
              style: const TextStyle(fontSize: 24),
            ),
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
                stream: FirebaseFirestore.instance.collection('comments').where('docu_id', isEqualTo: widget.documentIds).snapshots(), // 수정된 부분: postId 대신 documentIds 사용
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
                      String commentId = commentDoc.id; // 댓글의 문서 ID
                      String commentUserId = commentDoc['userId']; // 댓글을 작성한 사용자의 ID
                      bool canDeleteComment = widget.userId == commentUserId;
                      return ListTile(
                        title: Text(commentDoc['comment']),
                        subtitle: Text('By: ${commentUserId.substring(0, 4)}'),
                        trailing: canDeleteComment ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // 로그인한 사용자가 댓글을 작성한 경우에만 삭제 기능 활성화
                            deleteComment(commentId);
                          },
                        ) : null,
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

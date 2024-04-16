import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/tab/tab_page.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String userId;

  DetailPage({required this.title, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        actions: [
          IconButton(
            onPressed: () {
              // 뒤로가기 버튼 눌렀을 때 이전 페이지로 이동
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Title: $title',
              style: TextStyle(fontSize: 24),
            ),
            // 여기에 내용 수정 또는 댓글 기능 추가
          ],
        ),
      ),
    );
  }
}

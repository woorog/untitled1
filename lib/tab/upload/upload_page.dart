import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/tab/home/home_page.dart';
import 'package:untitled1/tab/tab_page.dart';

class UpLoad extends StatelessWidget {
  const UpLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시물 작성'),

        actions: [
          IconButton(
            onPressed: () {Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TabPage()),
            );},
            icon: const Icon(Icons.check_circle_sharp),
          ),
        ],
      ),
    );
  }
}

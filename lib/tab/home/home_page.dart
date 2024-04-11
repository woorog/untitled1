import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '홈페이지입니다',
        ),
      ),
      body: const Center(
        child: Row(
          children: [
            Text('asdasd'),
            Text('122312'),
          ],
        ),
      ),
    );
  }
}

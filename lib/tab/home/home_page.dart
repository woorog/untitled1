import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈페이지입니다 아마',),
      ),
      body: const Center(

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text('yesssssssss'),
                      SizedBox(height: 20),
                      Text('yesssssssss',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      Text('yesssssssss'),

                      Card(
                        child: Column(
                          children: [
                            Text('이미지'),
                            Text('이미지1'),
                            Text('이미지2'),
                            Text('이미지3'),
                            Text('이미지4'),
                            Text('이미지5'),
                          ],
                        ),

                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
      );
  }
}


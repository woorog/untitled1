import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  final List<String> _temp = const[
    'asdasd', 'fsdfsdf', 'ghjghjghj',
    'sdfsdfd',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: _temp.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), //3열
        itemBuilder: (BuildContext context, int index) {
          final temps=_temp[index];
          return Text(temps);
        },
      ),
    );
  }
}

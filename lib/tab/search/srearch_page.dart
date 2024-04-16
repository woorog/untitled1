import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../detailpage/detail_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('posts').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(), // 데이터가 로딩 중 위젯
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'), // 에러가 발생했을 때 보여줄 위젯
          );
        }
        // final List<String> titles = snapshot.data!.docs
        //     .map<String>((doc) => doc['title'] as String)
        //     .toList();
        // final List<String> userId = snapshot.data!.docs
        //     .map<String>((doc) => doc['userId'] as String)
        //     .toList();

        List<String> documentIds = [];
        List<String> contents = [];
        List<String> titles = [];
        List<String> userId = [];

        // 각 문서의 데이터를 가져와 리스트에 추가합니다.
        snapshot.data!.docs.forEach((doc) {
          documentIds.add(doc.id); // 문서 ID를 리스트에 추가합니다.
          contents.add(doc['contents'] as String);
          titles.add(doc['title'] as String);
          userId.add(doc['userId'] as String);
        });


        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('testPage'),
            ),
            body: GridView.builder(
              itemCount: titles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // 클릭된 항목의 제목 정보를 다음 화면으로 전달하면서 상세 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          title: titles[index],
                          userId: userId[index],
                          documentIds:documentIds[index],
                          contents:contents[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        'Item: ${titles[index]}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

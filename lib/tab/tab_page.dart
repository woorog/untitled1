import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/tab/account/writing_page.dart';
import 'package:untitled1/tab/home/home_page.dart';
import 'package:untitled1/tab/search/srearch_page.dart';

import '../login_page/loginmain.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int currentIndex = 0;
  final pages=const [
    HomePage(),
    SearchPage(),
    New(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'), actions: [
        IconButton(
          onPressed: () {
            // 로그아웃 버튼 클릭 시 로그아웃 실행
            FirebaseAuth.instance.signOut().then((_) {
              // 로그아웃 후에 로그인 페이지로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LogIn()),
              );
            }).catchError((error) {
              print('Failed to log out:');
            });
          },
          icon: const Icon(Icons.logout),
        ),
      ]),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex=index;
          });
          print(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'writing',
          ),
        ],
      ),
    );
  }
}

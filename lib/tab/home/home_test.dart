import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('로아랭'),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            // 사용자 프로필 섹션
            _buildUserProfileSection(),
            // 콘텐츠 리스트
            Expanded(
              child: ListView.builder(
                itemCount: 10, // 임시 항목 개수
                itemBuilder: (context, index) {
                  return _buildContentListItem(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: CupertinoColors.darkBackgroundGray,
        border: Border(
          bottom: BorderSide(color: CupertinoColors.separator, width: 0.0),
        ),
      ),
      child: const Row(
        children: <Widget>[
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('https://example.com/profile_image.png'),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'LV 60 마법사',
                style: TextStyle(color: CupertinoColors.white),
              ),
              Text(
                '1,555,000',
                style: TextStyle(color: CupertinoColors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContentListItem(int index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.star),
          title: Text('콘텐츠 제목 $index'),
          subtitle: Text('부제목 $index'),
          trailing: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}

// 在列表顶部放置一个浮动的导航栏（app bar）
//
//24-10-16 21:55

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Floating App Bar';

    return MaterialApp(
        title: title,
        home: Scaffold(
          body: CustomScrollView(slivers: [
            const SliverAppBar(
              title: Text('Floating App Bar'),
              floating: true, //使用户在向上滚动列表时能快速显示 app bar
              flexibleSpace: Placeholder(), // 填充可用的 expandedHeight
              expandedHeight: 200,
            ),
            SliverList(
              // 列表
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text('Item #$index')),
                childCount: 100,
              ),
            ),
          ]),
        ));
  }
}

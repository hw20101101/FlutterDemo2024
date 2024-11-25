import 'package:flutter/material.dart'; //风格1 - 谷歌推出
import 'package:flutter/cupertino.dart'; //风格2 - iOS
import 'package:provider/provider.dart';

import 'pages/tabbar_page.dart';
import 'providers/provider_page1.dart';

void main() {
  runApp(MyApp());
  // testProvider1();
}

// ==================== 1.包含 tabbar 的 APP demo ====================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      home: const IndexPage(),
    );
  }
}

// ==================== 2. 使用 Provider 来管理状态 ====================

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'title',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProviderPage1(),
    );
  }
}

void testProvider1() {
  runApp(ChangeNotifierProvider(
      //在构建器中初始化模型。这样，提供者 可以拥有Counter的生命周期，确保 当不再需要的时候 调用`dispose`
      create: (context) => CounterProvider1(),
      child: const MyApp()));
}

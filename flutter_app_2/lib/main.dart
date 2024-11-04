import 'package:flutter/material.dart'; //风格1 - 谷歌推出
import 'package:flutter/cupertino.dart'; //风格2 - iOS

import 'pages/Index_page.dart';

void main() {
  runApp(const MyApp());
}

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

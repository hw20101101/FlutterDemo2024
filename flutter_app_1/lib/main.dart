import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // 应用的起点
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  //每当 widget 的环境发生变化时，系统都会自动调用该方法，以便 widget 始终保持最新状态。
  Widget build(BuildContext context) {
    //MyHomePage 使用 watch 方法跟踪对应用当前状态的更改
    var appState = context.watch<MyAppState>();

    //每个 build 方法都必须返回一个 widget 或（更常见的）嵌套 widget 树。在本例中，顶层 widget 是 Scaffold
    return Scaffold(
      //Column 是 Flutter 中最基础的布局 widget 之一
      body: Column(
        children: [
          Text(
              'A random idea A random idea A random idea A random idea \n A random idea:'),
          Text(appState.current.asLowerCase),
          ElevatedButton(
            onPressed: () {
              print("button pressed");
            },
            child: Text("Next"),
          )
        ],
      ),
    );
  }
}

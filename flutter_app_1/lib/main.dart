// import 'dart:ffi';
// import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:provider/provider.dart';

void main() {
  // 应用的起点

  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

// ================= Navigator ↓ =================
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    //使用 CupertinoPageRoute 进行导航
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('First Route'),
      ),
      child: Center(
        child: CupertinoButton(
            child: const Text('Open route'),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const SecondRoute()),
              );
            }),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Second Route'),
        ),
        child: Center(
          child: CupertinoButton(
              child: const Text('Go back!'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ));
  }
}

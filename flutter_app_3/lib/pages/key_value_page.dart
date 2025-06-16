// 将数据存储在硬盘上。
// 注：如果你要存储的键值集合相对较少，则可以用 shared_preferences 插件，有以下局限性：

// 只能用于基本数据类型： int、double、bool、string 和 List<String>。
// 不是为存储大量数据而设计的。
// 不能确保应用重启后数据仍然存在。

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValuePage extends StatefulWidget {
  const KeyValuePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _KeyValuePageState();
  }
}

class _KeyValuePageState extends State<KeyValuePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  // 从硬盘加载数据
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  // 保存数据到硬盘
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

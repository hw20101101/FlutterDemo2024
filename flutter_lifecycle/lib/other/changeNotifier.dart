import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const ListenableBuilderExample());
}

// 要使用ChangeNotifier，首先需要创建一个继承自ChangeNotifier的类，
// 并在数据变化时调用 notifyListeners 方法。
class ListModel with ChangeNotifier {
  final List<int> _values = <int>[];
  List<int> get values => _values.toList(); // O(N), 每次都会制作一个新副本。

  // 每当调用 add 方法时，List 的值就会增加，并且通过 notifyListeners 通知所有监听器
  void add(int value) {
    _values.add(value);
    notifyListeners();
  }
}

class ListenableBuilderExample extends StatefulWidget {
  const ListenableBuilderExample({super.key});

  @override
  State<ListenableBuilderExample> createState() =>
      _ListenableBuilderExampleState();
}

class _ListenableBuilderExampleState extends State<ListenableBuilderExample> {
  final ListModel _listNotifier = ListModel();
  final math.Random _random = math.Random(0); // fixed seed for reproducibility

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ListenableBuilder Example')),
        body: ListBody(listNotifier: _listNotifier),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _listNotifier.add(_random
              .nextInt(1 << 31)), // 1 << 31 is the maximum supported value
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class ListBody extends StatelessWidget {
  const ListBody({super.key, required this.listNotifier});

  final ListModel listNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text('Current values:'),
          Expanded(
            // 任何使用 ListenableBuilder 或其他监听器的 widget都可以响应这个变化
            child: ListenableBuilder(
              listenable: listNotifier,
              builder: (BuildContext context, Widget? child) {
                //每次列表更改时，我们都会重建ListView，以便框架知道更新渲染。
                final List<int> values = listNotifier.values; // copy the list
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text('index:$index - value:${values[index]}'),
                  ),
                  itemCount: values.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

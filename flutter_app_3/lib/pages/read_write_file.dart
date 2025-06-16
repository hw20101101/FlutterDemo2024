// 读写文件

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CounterStorage {
  // 找到正确的本地路径
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 创建一个指向文件位置的引用
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  // 从文件读取数据
  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  // 将数据写入文件
  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    return file.writeAsString('$counter');
  }
}

class ReadWriteFile extends StatefulWidget {
  final CounterStorage storage;

  const ReadWriteFile({super.key, required this.storage});

  @override
  State<StatefulWidget> createState() {
    return _ReadWriteFileState();
  }
}

class _ReadWriteFileState extends State<ReadWriteFile> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });

    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ReadWriteFile')),
      body: Center(
        child:
            Text('Button tapped : $_counter time ${_counter == 1 ? '' : 's'}.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

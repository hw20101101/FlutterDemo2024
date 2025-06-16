import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/animation_page.dart';
import 'package:flutter_application_2/pages/isolate_page.dart';
import 'package:flutter_application_2/pages/key_value_page.dart';
import 'package:flutter_application_2/pages/msg_detail_page.dart';
import 'package:flutter_application_2/pages/read_write_file.dart';
import 'package:flutter_application_2/pages/sqlite_page.dart';

// 首页界面(设备列表)
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  // 每当 Flutter 需要更改视图中的任何内容时，就会调用 build() 方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('设备列表')),
        body: ListView(children: [
          ListTile(
            title: const Text("Test Isolate（线程调度）"),
            onTap: () {
              // 跳转下一个页面 IsolatePage
              listTileOnTap(const IsolatePage(
                title: 'IsolatePage',
              ));
            },
          ),
          ListTile(
            title: const Text("Key Value（将 key value 存储在硬盘中）"),
            onTap: () {
              // 跳转下一个页面
              listTileOnTap(const KeyValuePage(title: 'KeyValuePage'));
            },
          ),
          ListTile(
            title: const Text("文件读写"),
            onTap: () {
              // 跳转下一个页面
              listTileOnTap(ReadWriteFile(
                storage: CounterStorage(),
              ));
            },
          ),
          ListTile(
            title: const Text("SQLite 读写"),
            onTap: () {
              // 跳转下一个页面
              listTileOnTap(const SQLitePage(
                title: 'sqlitePage',
              ));
            },
          ),
          ListTile(
            title: const Text("动画"),
            onTap: () {
              // 跳转下一个页面
              listTileOnTap(const AnimationPage());
            },
          ),
          ListTile(
            title: const Text("消息详情"),
            onTap: () {
              // 跳转下一个页面
              listTileOnTap(const MessageDetailPage());
            },
          ),
        ]));
  }

  // 跳转下一个页面
  void listTileOnTap(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  //12-15 TODO: 用 SQLite 做数据持久化
}

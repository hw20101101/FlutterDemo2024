import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/message_page.dart';
import 'package:http/http.dart' as http;

// Album 模型
class Album {
  // final int userId;
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"id": int id, "title": String title} => Album(id: id, title: title),
      _ => throw const FormatException("failed to load album.")
    };
  }
}

// 首页界面(设备列表)
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late AppLifecycleState _appLifecycleState;
  late Future<Album> _futureAlbum;

  // http.Response 类包含成功的 http 请求接收到的数据;
  Future<Album> fetchAlbum() async {
    // print("-->> fetchAlbum");
    var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1");
    final response = await http.get(url);

    // 将 http.Response 转换成 Album
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('failed to load album');
    }
  }

  // 发起 HTTP 认证授权请求
  Future<Album> fetchAlbum2() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/12");
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: "your_api_token"});
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    print("-->> json: $json");
    return Album.fromJson(json);
  }

  Future<Album> createAlbum(String title) async {
    final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/albums'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'title': title}));

    print("-->> response: $response");

    if (response.statusCode == 201) {
      // 将http.Response转换为Album
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  // initState() 方法仅会被调用一次;

  // 为何要在 initState() 中调用 fetchPost() ？
  // 虽然这样会比较方便，但是我们仍然不推荐将 API 调用置于 build() 方法内部。

  // 将 fetchAlbum() 的结果存储在状态变量中，可确保 Future 只执行一次
  @override
  void initState() {
    super.initState();
    // print("-->> initState");

    //添加状态监听者
    WidgetsBinding.instance.addObserver(this);
    _appLifecycleState = WidgetsBinding.instance.lifecycleState!;
    // _futureAlbum = fetchAlbum2();
    _futureAlbum = createAlbum("test album");
  }

  // 每当 Flutter 需要更改视图中的任何内容时，就会调用 build() 方法
  @override
  Widget build(BuildContext context) {
    // print("-->> build");

    return Scaffold(
        appBar: AppBar(title: Text('设备列表')),
        // 显示网络请求返回的数据
        body: Center(
          child: FutureBuilder<Album>(
              future: _futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.title);
                } else if (snapshot.hasError) {
                  return Text("error:${snapshot.hasError}");
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        )

        // body: ListView(children: [
        //   deviceListTile(
        //     title: "1号设备",
        //     status: "在线",
        //     icon: Icons.camera,
        //     onTap: () {},
        //   ),
        //   deviceListTile(
        //     title: "2号设备",
        //     status: "离线",
        //     icon: Icons.camera,
        //     onTap: () {},
        //   ),
        // ])
        );
  }

  //设备列表项
  Widget deviceListTile(
      {String? title, String? status, IconData? icon, VoidCallback? onTap}) {
    return Column(
      children: [
        //设备名称、在线状态、设备图标
        Row(
          children: [
            SizedBox(width: 16),
            Icon(icon),
            Text(title!),
            Spacer(),
            Text(status!),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 10),
        //设备预览图
        Image.asset(
          "assets/device_bg.png",
          width: 340,
          height: 150,
          fit: BoxFit.cover,
        ),
        //底部的按钮数组
        Row(
          children: [
            Spacer(),
            bottomButtonItem("回放", Icons.video_call, () {}),
            Spacer(),
            bottomButtonItem("消息", Icons.message, () {
              // print("-->> 点击消息按钮");
              _navigateAndDisplaySelection(context);
            }),
            Spacer(),
            bottomButtonItem("分享", Icons.share, () {}),
            Spacer(),
            bottomButtonItem("设置", Icons.settings, () {}),
            Spacer(),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }

  //消息按钮点击事件
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.

    //定义要传到下个页面的数据
    var message = Message("title-张三", "desc-test");

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MessagePage(
                datas: "0",
              ),
          settings: RouteSettings(arguments: message)),
    );
    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!context.mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('在页面底部显示结果: $result')));
  }

  @override
  void dispose() {
    //移除状态监听者
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
    });

    super.didChangeAppLifecycleState(state);
    print("--> state: $state");

    /* 前台切换后台：
    flutter: --> state: AppLifecycleState.inactive 不活跃
    flutter: --> state: AppLifecycleState.hidden
    flutter: --> state: AppLifecycleState.paused 暂停
    */

    /* 后台切换前台：
    flutter: --> state: AppLifecycleState.hidden
    flutter: --> state: AppLifecycleState.inactive
    flutter: --> state: AppLifecycleState.resumed 继续
     */

    switch (state) {
      case AppLifecycleState.detached:
      // TODO: Handle this case.
      case AppLifecycleState.resumed:
      // TODO: Handle this case.
      case AppLifecycleState.inactive:
      // TODO: Handle this case.
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
      case AppLifecycleState.paused:
      // TODO: Handle this case.
    }
  }

  //底部按钮
  bottomButtonItem(String title, IconData icon, Null Function() onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
        Text(title),
      ],
    );
  }
}

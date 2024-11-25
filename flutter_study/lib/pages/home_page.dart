import 'package:flutter/material.dart';

// 首页界面(设备列表)
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late AppLifecycleState _appLifecycleState;

  @override
  void initState() {
    super.initState();

    //添加状态监听者
    WidgetsBinding.instance.addObserver(this);
    _appLifecycleState = WidgetsBinding.instance.lifecycleState!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('设备列表')),
        body: ListView(children: [
          deviceListTile(
            title: "1号设备",
            status: "在线",
            icon: Icons.camera,
            onTap: () {},
          ),
          deviceListTile(
            title: "2号设备",
            status: "离线",
            icon: Icons.camera,
            onTap: () {},
          ),
        ]));
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
            bottomButtonItem("回放", Icons.control_camera, () {}),
            Spacer(),
            bottomButtonItem("消息", Icons.settings, () {}),
            Spacer(),
            bottomButtonItem("分享", Icons.share, () {}),
            Spacer(),
            bottomButtonItem("设置", Icons.more_horiz, () {}),
            Spacer(),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
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

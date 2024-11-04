import 'package:flutter/material.dart';

// 商城首页界面
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
    return Scaffold(body: Center(child: Text('首页 state: $_appLifecycleState')));
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
}

import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int _counter = 0;

  //当Widget第一次插入到Widget树时会被调用。对于每一个State对象，Flutter只会调用该回调一次
  @override
  void initState() {
    super.initState();
    print("page2 parent initState......");

    // 访问 Page2 的key
    final key = widget.key;
    try {
      // Null check operator used on a null value
      print('Page2 key: ${key!.toString()}');
    } catch (e) {
      print("Page2 key: $e");
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print("page2 parent setState......");
  }

  /*
  *初始化时，在initState之后立刻调用
  *当State的依赖关系发生变化时，会触发此接口被调用
  */
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeDependencies();
    print('Page2: didChangeAppLifecycleState: $state');
  }

  //绘制界面
  @override
  Widget build(BuildContext context) {
    print("page2 parent build......");
    return Scaffold(
      appBar: AppBar(title: const Text("Page2")),
      body: Center(
        child: TextButton(
          //点击事件
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: ChildPage2(count: _counter),
        ),
      ),
    );
  }

  //状态改变的时候会调用该方法,比如父类调用了setState
  @override
  void didUpdateWidget(covariant Page2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("page2 parent didUpdateWidget......");
  }

  //当State对象从树中被移除时，会调用此回调
  @override
  void deactivate() {
    super.deactivate();
    print("page2 parent deactivate......");
  }

  //当State对象从树中被永久移除时调用；通常在此回调中释放资源
  @override
  void dispose() {
    super.dispose();
    print("page2 parent dispose......");
  }
}

class ChildPage2 extends StatefulWidget {
  final int count;
  ChildPage2({Key? key, required this.count}) : super(key: key);

  @override
  _ChildPage2State createState() => _ChildPage2State();
}

class _ChildPage2State extends State<ChildPage2> {
  //绘制界面
  @override
  Widget build(BuildContext context) {
    print("child page2 build......");
    return Text('点击按钮查看状态变化 count: ${widget.count}');
  }

  //当Widget第一次插入到Widget树时会被调用。对于每一个State对象，Flutter只会调用该回调一次
  @override
  void initState() {
    super.initState();
    print("child page2 initState......");
  }

  /*
  *初始化时，在initState之后立刻调用
  *当State的依赖关系发生变化时，会触发此接口被调用
  */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("child page2 didChangeDependencies......");
  }

  //状态改变的时候会调用该方法,比如父类调用了setState
  @override
  void didUpdateWidget(covariant ChildPage2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("child page2 didUpdateWidget......");
  }

  //当State对象从树中被移除时，会调用此回调
  @override
  void deactivate() {
    super.deactivate();
    print("child page2 deactivate......");
  }

  //当State对象从树中被永久移除时调用；通常在此回调中释放资源
  @override
  void dispose() {
    super.dispose();
    print("child page2 dispose......");
  }
}

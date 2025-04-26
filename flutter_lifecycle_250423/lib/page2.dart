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
      appBar: AppBar(title: Text("Page2")),
      body: Center(
        child: TextButton(
          //点击事件
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: Text("times: $_counter"),
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

import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_250423/normal_page2.dart';

class Page1 extends StatefulWidget {
  Page1({Key? key}) : super(key: key);
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with WidgetsBindingObserver {
  //当Widget第一次插入到Widget树时会被调用。对于每一个State对象，Flutter只会调用该回调一次
  @override
  void initState() {
    super.initState();
    //首次 调用顺序 1
    print("page1 initState......");
    WidgetsBinding.instance.addObserver(this); //注册监听器

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //首次 调用顺序 5
      print("单次Frame绘制回调"); //只回调一次
    });

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      //首次 调用顺序 4
      print("实时Frame绘制回调"); //每帧都回调
      //update 调用顺序 3
    });

    //延迟调用
    // Future.delayed(Duration(seconds: 5), () {
    //   // 故意制造一个空指针异常
    //   String? data;
    //   print(data!.length);
    // });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print("page1 setState......");
  }

  /*
  *初始化时，在initState之后立刻调用
  *当State的依赖关系发生变化时，会触发此接口被调用
  */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //首次 调用顺序 2
    print("page1 didChangeDependencies......");
  }

  //绘制界面
  @override
  Widget build(BuildContext context) {
    //首次 调用顺序 3
    print("page1 build......");
    //update 调用顺序 2
    return Scaffold(
      appBar: AppBar(
        title: Text('Page1'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page2())),
                child: Text("打开/关闭新页面查看状态变化"))
            // TextButton(
            //     onPressed: () => print('-- onPressed'),
            //     child: Text("打开/关闭新页面查看状态变化"))
          ],
        ),
      ),
    );
  }

  //状态改变的时候会调用该方法,比如父类调用了setState
  @override
  void didUpdateWidget(Page1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    //update 调用顺序 1
    print("page1 didUpdateWidget......");
  }

  //当State对象从树中被移除时，会调用此回调
  @override
  void deactivate() {
    super.deactivate();
    print('page1 deactivate......');
  }

  //当State对象从树中被永久移除时调用；通常在此回调中释放资源
  @override
  void dispose() {
    super.dispose();
    print('page1 dispose......');
    WidgetsBinding.instance.removeObserver(this); //移除监听器
  }

  //监听App生命周期回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("page1 state:$state");
    if (state == AppLifecycleState.resumed) {
      //do sth
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 会员中心界面

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<StatefulWidget> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  //短暂状态( app 中的其他部分不需要访问 _index，这个变量只会在 MemberPage widget 中改变)
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //顶部导航栏
        appBar: AppBar(
          title: const Text('我的'),
        ),
        body: Center(
          child: CupertinoButton(
              child: Text('你敢点我试试? : $_index'),
              //按钮点击事件
              onPressed: () {
                setState(() {
                  _index += 1;
                });
              }),
        ));
  }
}

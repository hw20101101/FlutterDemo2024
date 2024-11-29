import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/home_page.dart';
import 'package:flutter_application_2/pages/member_page.dart';

// StatefulWidget - 动态组件
class TabbarPage extends StatefulWidget {
  const TabbarPage({super.key});

  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  //定义底部的 tabar
  final List<BottomNavigationBarItem> bottomTabs = [
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: '我的')
  ];

  // 定义 tabbar item 对应的页面
  final List tabItems = [HomePage(), MemberPage()];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    //默认选中的 tabItem
    currentPage = tabItems[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 244, 255, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomTabs,
        currentIndex: currentIndex,
        //点击事件
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabItems[currentIndex];
          });
        },
      ),
      body: currentPage,
    );
  }
}

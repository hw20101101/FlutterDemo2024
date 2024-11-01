import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';

// StatelessWidget - 静态组件
/*
class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('百姓生活'),
      ),
      body: const Center(
        child: Text('百姓生活 ++'),
      ),
    );
  }
} */

// StatefulWidget - 动态组件
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //定义底部的 tabar
  final List<BottomNavigationBarItem> bottomTabs = [
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), label: '分类'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), label: '购物车'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: '我的')
  ];

  // 定义 tabbar item 对应的页面
  final List tabItems = [HomePage(), CartPage(), CategoryPage(), MemberPage()];

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

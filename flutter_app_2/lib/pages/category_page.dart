import 'dart:ffi';

import 'package:flutter/material.dart';

// 分类界面
class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //测试异步函数
    testAsync();

    return Scaffold(body: Center(child: Text('分类页面')));
  }
}

Future<void> testAsync() async {
  print(await createOrderMessage());
}

Future<String> createOrderMessage() async {
  var order = await fetchUserOrder();
  return "your order is: $order";
}

Future<String> fetchUserOrder() =>
    Future.delayed(const Duration(seconds: 2), () => 'lagre latte');

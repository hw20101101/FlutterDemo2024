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

void testAsync() {
  print(createOrderMessage());
}

String createOrderMessage() {
  var order = fetchUserOrder();
  return "your order is: $order";
}

Future<String> fetchUserOrder() =>
    Future.delayed(const Duration(seconds: 2), () => 'lagre latte');

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
  countSeconds(4);
  await createOrderMessage();
}

Future<void> countSeconds(int s) async {
  for (int i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print('index: $i'));
  }
}

Future<void> createOrderMessage() async {
  var order = await fetchUserOrder();
  print("awaiting user order...");
  print("your order is: $order");
}

Future<String> fetchUserOrder() =>
    Future.delayed(const Duration(seconds: 4), () => 'lagre latte');

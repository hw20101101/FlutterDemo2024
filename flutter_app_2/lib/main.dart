import 'package:flutter/material.dart'; //风格1 - 谷歌推出
import 'package:flutter/cupertino.dart'; //风格2 - iOS
import 'package:provider/provider.dart';

import 'pages/Index_page.dart';

void main() {
  runApp(const MyApp());

// 将模型提供给应用程序中的所有小部件。
// https://github.com/flutter/samples/tree/main/provider_counter
// https://pub.dev/packages/provider

// runApp(ChangeNotifierProvider(
//     //在构建器中初始化模型。这样，提供者 可以拥有Counter的生命周期，确保 当不再需要的时候 调用`dispose`
//     create: (context) => Counter(),
//     child: const MyApp()));
}

// ==================== 1. 使用 Provider 来管理状态 ====================

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'title',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('home page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('times:'),
//             //消费者寻找祖先提供者小部件
//             //并检索其模型（在本例中为计数器）。
//             //然后，它使用该模型构建小部件，并将触发
//             //如果模型更新，则重建。
//             Consumer<Counter>(
//                 builder: (context, counter, child) => Text(
//                       '${counter.value}',
//                       style: Theme.of(context).textTheme.headlineLarge,
//                     ))
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           //您可以在任何有权访问的地方访问您的提供商
//           //根据上下文。一种方法是使用<Counter>的提供者（上下文）。
//           //
//           //提供者包还定义了上下文上的扩展方法
//           //本身。您可以在构建方法中调用context.watch<Counter>（）
//           //任何小部件都可以访问Counter的当前状态，并询问
//           //Flutter可以在Counter更改时重建您的小部件。
//           //
//           //你不能在构建方法之外使用context.watch（），因为
//           //通常会导致微妙的错误。相反，你应该使用
//           //context.read<Counter>（），获取当前状态
//           //但不会要求Flutter进行未来的重建。
//           //
//           //因为我们处于一个回调中，每当用户
//           //点击FloatingActionButton，我们不在这里的构建方法中。
//           //我们应该使用context.read（）。
//           var counter = context.read<Counter>();
//           counter.increment();
//         },
//         tooltip: 'increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class Counter with ChangeNotifier {
//   int value = 0;

//   void increment() {
//     value += 1;
//     notifyListeners();
//   }
// }

// ==================== 2.包含 tabbar 的 APP demo ====================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      home: const IndexPage(),
    );
  }
}

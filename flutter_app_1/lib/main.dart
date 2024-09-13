import 'dart:ffi';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // 应用的起点
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          //设置主题色
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();

    //确保向任何通过 watch 方法跟踪 MyAppState 的对象发出通知
    notifyListeners();
  }

  //添加收藏（业务逻辑）
  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }

    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  //每当 widget 的环境发生变化时，系统都会自动调用该方法，以便 widget 始终保持最新状态。
  Widget build(BuildContext context) {
    //MyHomePage 使用 watch 方法跟踪对应用当前状态的更改
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    //每个 build 方法都必须返回一个 widget 或（更常见的）嵌套 widget 树。在本例中，顶层 widget 是 Scaffold
    return Scaffold(
      //Column 是 Flutter 中最基础的布局 widget 之一，它接受任意数量的子项并将这些子项从上到下放在一列中
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            // 'A random idea A random idea A random idea A random idea \n A random idea:'),
            // Text(appState.current.asLowerCase),
            BigCard(pair: pair),

            //增加垂直方向的间距
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //收藏按钮
                ElevatedButton.icon(
                    onPressed: () {
                      appState.toggleFavorite();
                    },
                    icon: Icon(icon),
                    label: Text("Like")),

                SizedBox(
                  width: 14,
                ),

                //下一个按钮
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text("Next"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//重构 Text Widget
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    //使用 Theme.of(context) 请求应用的当前主题
    final theme = Theme.of(context);

    //通过使用 theme.textTheme,，您可以访问应用的字体主题
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    //使用 Padding Widget 增加间距
    return Card(
      //将卡片的颜色定义为与主题的 colorScheme 属性相同
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

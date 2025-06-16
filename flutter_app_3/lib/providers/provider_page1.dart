import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider1 with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }
}

class ProviderPage1 extends StatelessWidget {
  const ProviderPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('times:'),
            //消费者寻找祖先提供者小部件
            //并检索其模型（在本例中为计数器）。
            //然后，它使用该模型构建小部件，并将触发
            //如果模型更新，则重建。
            Consumer<CounterProvider1>(
                builder: (context, counter, child) => Text(
                      '${counter.value}',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //您可以在任何有权访问的地方访问您的提供商
          //根据上下文。一种方法是使用<Counter>的提供者（上下文）。
          //
          //提供者包还定义了上下文上的扩展方法
          //本身。您可以在构建方法中调用context.watch<Counter>（）
          //任何小部件都可以访问Counter的当前状态，并询问
          //Flutter可以在Counter更改时重建您的小部件。
          //
          //你不能在构建方法之外使用context.watch（），因为
          //通常会导致微妙的错误。相反，你应该使用
          //context.read<Counter>（），获取当前状态
          //但不会要求Flutter进行未来的重建。
          //
          //因为我们处于一个回调中，每当用户
          //点击FloatingActionButton，我们不在这里的构建方法中。
          //我们应该使用context.read（）。
          var counter = context.read<CounterProvider1>();
          counter.increment();
        },
        tooltip: 'increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

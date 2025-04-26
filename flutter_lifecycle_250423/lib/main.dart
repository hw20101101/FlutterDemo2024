import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_250423/page1.dart';

void main() {
  // 捕捉 Flutter 框架层的错误
  FlutterError.onError = (FlutterErrorDetails details) {
    // 这里不再调用 FlutterError.presentError(details)，防止显示红屏
    _handleFlutterError(details.exception, details.stack ?? StackTrace.empty);
  };

  // 捕捉 Dart 异步的错误
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    _handleFlutterError(error, stackTrace);
  });
}

void _handleFlutterError(Object error, StackTrace stackTrace) {
  print('发生了错误: $error');
  // 这里直接切换到友好的错误页面
  _navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const FriendlyErrorPage()),
    (route) => false,
  );
}

// 创建一个全局导航 key
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey, // 挂上全局 navigator key
      home: Page1(),
    );
  }
}

// ======= 自定义友好的错误页面 =======
class FriendlyErrorPage extends StatelessWidget {
  const FriendlyErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 100),
            const SizedBox(height: 20),
            const Text(
              '哎呀，出了点小问题～',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 重新回到首页
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Page1()),
                  (route) => false,
                );
              },
              child: const Text('返回首页 Page1'),
            )
          ],
        ),
      ),
    );
  }
}

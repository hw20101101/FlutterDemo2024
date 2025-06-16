// ======= 自定义友好的错误页面 =======
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_250423/page1.dart';

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

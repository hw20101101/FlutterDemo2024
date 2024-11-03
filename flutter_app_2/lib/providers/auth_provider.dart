// Flutter 最佳实践和编码准则
// https://ducafecat.medium.com/flutter-最佳实践和编码准则-54d07752c545

// 遵循代码规范
// 在lib/目录中，避免使用相对导入。请使用包导入。

//  Bad
/*
import 'widgets/text_input.dart';
import 'widgets/button.dart'
import '../widgets/custom_tile.dart';
*/

// Good
/*
import 'package:coding_guidelines/widgets/text_input.dart';
import 'package:coding_guidelines/widgets/button.dart'
import 'package:coding_guidelines/widgets/custom_tile.dart';
*/

// 避免使用 print 打印语句

//  Bad
void f(int x) {
  print('debug: $x');
}

// Good
/*
void f2(int x) {
  debugPrint('debug: $x');  // error
} */

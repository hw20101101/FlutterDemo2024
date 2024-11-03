// 类、枚举、类型定义、混入和扩展的名称应使用大驼峰命名法。

class ClassName {}

extension ExtensionName on String {}

enum EnumName { first, second }

mixin MixinName {} // 混入 ？

typedef FunctionName = void Function();

// Libraries、包、目录和源文件的名称应该使用蛇形命名法（小写字母加下划线）。

// 导入的前缀命名应该使用蛇形命名法（小写字母加下划线）
// import 'package:dio/dio.dart' as dio;

// 变量、常量、参数和命名参数应该使用小驼峰命名法。

// 私有变量名前面加下划线。
class ClassName2 {
  String _varName = '';
}

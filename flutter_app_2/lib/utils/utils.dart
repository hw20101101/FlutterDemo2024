// 避免不必要地创建 lambda 函数

// 例如，在 Dart 中，下面的代码演示了如何使用箭头语法定义一个 lambda 函数：在可以使用 tear-off 的情况下，避免不必要地创建 lambda 函数。如果一个函数只是简单地调用一个带有相同参数的方法，就没有必要手动将调用包装在 lambda 函数中。

// bad code
import 'package:flutter_application_2/models/user.dart';

void testBad() {
  List<int> oddNum = [1, 3, 4, 5, 6];
  oddNum.forEach((number) {
    print(number);
  });
}

// good code
void testGood() {
  List<int> oddNum = [1, 3, 4, 5, 6];
  oddNum.forEach(print);
}

// 使用扩展集合简化您的代码

// 当你已经在另一个集合中存储了现有的项目时，利用扩展集合可以简化代码。

// bad code
void testBad2() {
  List<int> firstNum = [1, 3, 5, 7, 9];
  List<int> secondNum = [2, 4, 6, 8];
  firstNum.addAll(secondNum);
}

// good code
void testGood2() {
  List<int> secondNum = [2, 4, 6, 8];
  List<int> firstNum = [1, 3, 5, 7, 9, ...secondNum];
}

// 使用级联操作简化对象操作

// Cascades（级联）操作符非常适合在同一对象上执行一系列操作，使代码更加简洁易读

void badCode() {
  final user = User();
  user.name = "zhang san";
  user.age = 20;
  print(user.toString());
}

void goodCode() {
  final user = User();
  user
    ..name = "zhang san"
    ..age = 20;
  print(user.toString());
}

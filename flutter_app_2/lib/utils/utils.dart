// 避免不必要地创建 lambda 函数

// 例如，在 Dart 中，下面的代码演示了如何使用箭头语法定义一个 lambda 函数：在可以使用 tear-off 的情况下，避免不必要地创建 lambda 函数。如果一个函数只是简单地调用一个带有相同参数的方法，就没有必要手动将调用包装在 lambda 函数中。

// bad code
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

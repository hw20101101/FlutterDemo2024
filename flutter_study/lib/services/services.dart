// 使用可空运算符

// 在处理条件表达式时，建议使用 ?? （如果为null）和 ?. （null aware）运算符，而不是显式的null检查。

// ?? （如果为空）运算符：
class ClassName {
  String? name;

  void test() {
    name = name ?? "";
  }
}

// ?. （空值安全）运算符：
class ClassName2 {
  String? name;

  void test() {
    name = name?.length.toString();
  }
}

// 为了避免潜在的异常情况，在Flutter中建议使用 is 运算符而不是 as 强制转换运算符。 is 运算符允许更安全地进行类型检查，如果转换不可能，也不会抛出异常。

class ClassName3 {
  var person;

  void test() {
    if (person is DateTime) {
      person.name = '';
    }
  }
}

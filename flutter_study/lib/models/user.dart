import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

class User {
  String? name;
  int? age;

  User({this.name, this.age});

  @override
  String toString() {
    return "name: $name, age: $age";
  }
}

// - - - - - -  在模型类中序列化 JSON 数据 - - - - - -
// https://docs.flutter.cn/data-and-backend/serialization/json

class User2 {
  final String name;
  final String email;

  User2(this.name, this.email);

  // 用于从映射中构造一个新的 User 实例
  User2.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        email = json['email'] as String;

  // 将 User 实例转换为一个映射
  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}

// TODO 使用单元测试进行验证
void testJson(String jsonString) {
  // 解码获得一个 user 实例
  final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
  final user = User2.fromJson(userMap);

  // 对 user 实例进行编码
  String json = jsonEncode(user);
}

// 以 json_serializable 的方式创建模型类

@JsonSerializable()
class User3 {
  String name;
  String email;

  User3(this.name, this.email);

  // dart run build_runner build --delete-conflicting-outputs
  factory User3.fromJson(Map<String, dynamic> json) => _$User3FromJson(json);

  Map<String, dynamic> toJson() => _$User3ToJson(this);
}

// 使用 json_serializable 模型
void useJsonSerializable(String jsonString) {
  // 解码获得一个 user 实例
  final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
  final user = User3.fromJson(userMap);

  // 对 user 实例进行编码
  String json = jsonEncode(user);
}

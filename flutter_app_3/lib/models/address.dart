import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

//--------- 为嵌套类 (Nested Classes) 生成代码 ---------

@JsonSerializable(explicitToJson: true)
class Address {
  String street;
  String city;

  Address(this.street, this.city);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

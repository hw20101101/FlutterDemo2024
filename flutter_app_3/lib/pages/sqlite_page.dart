// 用 SQLite 做数据持久化

// 总的来说，相比于其他本地持久化方案来说，数据库能够提供更为迅速的插入、更新、查询功能。

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({required this.id, required this.name, required this.age});

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

class SQLitePage extends StatefulWidget {
  const SQLitePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SQLitePageState();
  }
}

class _SQLitePageState extends State<SQLitePage> {
  @override
  void initState() {
    super.initState();
    testSqlite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('test Sqlite'),
          ],
        ),
      ),
    );
  }
}

void testSqlite() async {
  // 打开数据库
  WidgetsFlutterBinding.ensureInitialized();

  // 创建 dogs 表
  final database =
      openDatabase(join(await getDatabasesPath(), 'doggie_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
  }, version: 1);

  // 插入一条 dog 的数据
  Future<void> insertDog(Dog dog) async {
    final db = await database;
    await db.insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // 查询 dog 列表
  Future<List<Dog>> dogs() async {
    final db = await database;
    final List<Map<String, Object?>> dogMaps = await db.query('dogs');

    return [
      for (final {'id': id as int, 'name': name as String, 'age': age as int}
          in dogMaps)
        Dog(id: id, name: name, age: age)
    ];
  }

  // 修改一条 Dog 数据
  Future<void> updateDog(Dog dog) async {
    final db = await database;
    // 使用 whereArgs 将参数传递给 where 语句，有助于防止 SQL 注入攻击。
    // 这里不要使用字符串模板，比如： where: "id = ${dog.id}"！
    await db.update('dogs', dog.toMap(), where: 'id = ?', whereArgs: [dog.id]);
  }

  // 删除一条 Dog 数据
  Future<void> deleteDog(int id) async {
    final db = await database;
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }

  var fido = Dog(id: 0, name: 'Fido', age: 35);

  //插入一条数据
  await insertDog(fido);
  print(await dogs());

  fido = Dog(id: fido.id, name: fido.name, age: fido.age + 2);

  //更新一条数据
  await updateDog(fido);
  print(await dogs());

  //删除一条数据
  await deleteDog(fido.id);
  print(await dogs());
}

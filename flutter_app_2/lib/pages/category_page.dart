import 'dart:ffi';

import 'package:flutter/material.dart';

// 分类界面
class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //测试异步函数
    // testAsync();
    // testAsync2();
    // testAsync3();
    // testAsync4();
    testStream();

    return Scaffold(body: Center(child: Text('分类页面')));
  }
}

Future<void> testAsync() async {
  countSeconds(4);
  await createOrderMessage();
}

Future<void> countSeconds(int s) async {
  for (int i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print('index: $i'));
  }
}

Future<void> createOrderMessage() async {
  try {
    print("awaiting user order...");
    var order = await fetchUserOrder();
    print("your order is: $order");
  } catch (err) {
    print("catch err is: $err");
  }
}

// Future<String> fetchUserOrder() =>
//     Future.delayed(const Duration(seconds: 4), () => 'lagre latte');

Future<String> fetchUserOrder() {
  var str = Future.delayed(
      const Duration(seconds: 4), () => throw 'cannot locate user order');
  return str;
}

//  ===  ===  ===  ===  === 练习使用异步和等待 ↓  ===  ===  ===  ===  ===
// https://dart.cn/libraries/async/async-await/

// Part 1
// Call the provided async function fetchRole()
// to return the user role.
Future<String> reportUserRole() async {
  final username = await fetchRole();
  return "User role: $username";
}

// Part 2
// Call the provided async function fetchLoginAmount()
// to return the number of times that the user has logged in.
Future<String> reportLogins() async {
  final logins = await fetchLoginAmount();
  return "Total number of logins: $logins";
}

// The following functions those provided to you to simulate
// asynchronous operations that could take a while.

Future<String> fetchRole() => Future.delayed(_halfSecond, () => _role);
Future<int> fetchLoginAmount() => Future.delayed(_halfSecond, () => _logins);

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void testAsync2() async {
  print('Testing...');
  List<String> messages = [];
  const passed = 'PASSED';
  const testFailedMessage = 'Test failed for the function:';
  const typoMessage = 'Test failed! Check for typos in your return value';
  try {
    messages
      ..add(_makeReadable(
          testLabel: 'Part 1',
          testResult: await _asyncEquals(
            expected: 'User role: administrator',
            actual: await reportUserRole(),
            typoKeyword: _role,
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null':
                'Test failed! Did you forget to implement or return from reportUserRole?',
            'User role: Instance of \'Future<String>\'':
                '$testFailedMessage reportUserRole. Did you use the await keyword?',
            'User role: Instance of \'_Future<String>\'':
                '$testFailedMessage reportUserRole. Did you use the await keyword?',
            'User role:':
                '$testFailedMessage reportUserRole. Did you return a user role?',
            'User role: ':
                '$testFailedMessage reportUserRole. Did you return a user role?',
            'User role: tester':
                '$testFailedMessage reportUserRole. Did you invoke fetchRole to fetch the user\'s role?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 2',
          testResult: await _asyncEquals(
            expected: 'Total number of logins: 42',
            actual: await reportLogins(),
            typoKeyword: _logins.toString(),
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null':
                'Test failed! Did you forget to implement or return from reportLogins?',
            'Total number of logins: Instance of \'Future<int>\'':
                '$testFailedMessage reportLogins. Did you use the await keyword?',
            'Total number of logins: Instance of \'_Future<int>\'':
                '$testFailedMessage reportLogins. Did you use the await keyword?',
            'Total number of logins: ':
                '$testFailedMessage reportLogins. Did you return the number of logins?',
            'Total number of logins:':
                '$testFailedMessage reportLogins. Did you return the number of logins?',
            'Total number of logins: 57':
                '$testFailedMessage reportLogins. Did you invoke fetchLoginAmount to fetch the number of user logins?',
          }))
      ..removeWhere((m) => m.contains(passed))
      ..toList();

    if (messages.isEmpty) {
      print('Success. All tests passed!');
    } else {
      messages.forEach(print);
    }
  } on UnimplementedError {
    print(
        'Test failed! Did you forget to implement or return from reportUserRole?');
  } catch (e) {
    print('Tried to run solution, but received an exception: $e');
  }
}

const _role = 'administrator';
const _logins = 42;
const _halfSecond = Duration(milliseconds: 500);

// Test helpers.
String _makeReadable({
  required String testResult,
  required Map<String, String> readableErrors,
  required String testLabel,
}) {
  if (readableErrors.containsKey(testResult)) {
    var readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

// Assertions used in tests. 断言
Future<String> _asyncEquals({
  required String expected,
  required dynamic actual,
  required String typoKeyword,
}) async {
  var strActual = actual is String ? actual : actual.toString();
  try {
    if (expected == actual) {
      return 'PASSED';
    } else if (strActual.contains(typoKeyword)) {
      return 'Test failed! Check for typos in your return value';
    } else {
      return strActual;
    }
  } catch (e) {
    return e.toString();
  }
}

// ===  ===  ===  ===  === 3 练习处理错误 ===  ===  ===  ===  ===

Future<String> changeUsername() async {
  try {
    var name = await fetchNewUsername();
    return name; //jane_smith_92
  } catch (err) {
    //throw "\n error is: $err";
    return err.toString();
  }
}

// The following function is provided to you to simulate
// an asynchronous operation that could take a while and
// potentially throw an exception.

Future<String> fetchNewUsername() =>
    Future.delayed(const Duration(milliseconds: 500), () => "jane_smith_92");
// Future.delayed(const Duration(milliseconds: 500), () => throw UserError());

class UserError implements Exception {
  @override
  String toString() => 'New username is invalid';
}

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void testAsync3() async {
  final List<String> messages = [];
  const typoMessage = 'Test 2 failed! Check for typos in your return value';

  print('Testing 2...');
  try {
    messages
      ..add(_makeReadable3(
          testLabel: '',
          testResult: await _asyncDidCatchException(changeUsername),
          readableErrors: {
            typoMessage: typoMessage,
            _noCatch:
                'Did you remember to call fetchNewUsername within a try/catch block?',
          }))
      ..add(_makeReadable3(
          testLabel: '',
          testResult: await _asyncErrorEquals(changeUsername),
          readableErrors: {
            typoMessage: typoMessage,
            _noCatch:
                'Did you remember to call fetchNewUsername within a try/catch block?',
          }))
      ..removeWhere((m) => m.contains(_passed))
      ..toList();

    if (messages.isEmpty) {
      print('Success 2. All tests passed!');
    } else {
      messages.forEach(print);
    }
  } catch (e) {
    print('Tried to run solution, but received an exception: $e');
  }
}

// Test helpers.
String _makeReadable3({
  required String testResult,
  required Map<String, String> readableErrors,
  required String testLabel,
}) {
  if (readableErrors.containsKey(testResult)) {
    final readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

Future<String> _asyncErrorEquals(Function fn) async {
  final result = await fn();
  if (result == UserError().toString()) {
    return _passed;
  } else {
    return 'Test 2 failed! Did you stringify and return the caught error?';
  }
}

Future<String> _asyncDidCatchException(Function fn) async {
  var caught = true;
  try {
    await fn();
  } on UserError catch (_) {
    caught = false;
  }

  if (caught == false) {
    return _noCatch;
  } else {
    return _passed;
  }
}

const _passed = 'PASSED';
const _noCatch = 'NO_CATCH';

// ===  ===  ===  ===  === 4 练习异步函数-注销用户 ===  ===  ===  ===  ===

// Part 1
addHello(String user) {
// addHello()返回其String参数，前面是'Hello '”。
// 示例：addHello('Jon')返回'Hello Jon'”。
  return "Hello $user";
}

// Part 2
// Call the provided async function fetchUsername()
// to return the username.
Future<String> greetUser() async {
// 为了获取用户名，greetUser()调用提供的异步函数fetchUsername()
// greetUser()通过调用addHello()传递用户名，并返回结果，为用户创建问候语。
// 示例：如果fetchUsername()返回'Jenny'”，则greetUser()返回'Hello Jenny'”。
  var user = await fetchUsername();
  return addHello(user);
  // return "Hello $user";
}

// Part 3
// Call the provided async function logoutUser()
// to log out the user.
Future<String> sayGoodbye() async {
//   发现任何错误。
// 调用提供的异步函数logoutUser()
  try {
    final user = await logoutUser();
    return "$user Thanks, see you next time";
  } catch (err) {
    return "failed to logout user: $err";
  }
}

// The following functions are provided to you to use in your solutions.

Future<String> fetchUsername() => Future.delayed(_halfSecond4, () => 'Jean');

Future<String> logoutUser() => Future.delayed(_halfSecond4, _failOnce);

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void testAsync4() async {
  const didNotImplement =
      'Test failed! Did you forget to implement or return from';

  final List<String> messages = [];

  print('Testing...');
  try {
    messages
      ..add(_makeReadable4(
          testLabel: 'Part 1',
          testResult: await _asyncEquals4(
              expected: 'Hello Jerry',
              actual: addHello('Jerry'),
              typoKeyword: 'Jerry'),
          readableErrors: {
            _typoMessage4: _typoMessage4,
            'null': '$didNotImplement addHello?',
            'Hello Instance of \'Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
            'Hello Instance of \'_Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
          }))
      ..add(_makeReadable4(
          testLabel: 'Part 2',
          testResult: await _asyncEquals4(
              expected: 'Hello Jean',
              actual: await greetUser(),
              typoKeyword: 'Jean'),
          readableErrors: {
            _typoMessage4: _typoMessage4,
            'null': '$didNotImplement greetUser?',
            'HelloJean':
                'Looks like you forgot the space between \'Hello\' and \'Jean\'',
            'Hello Instance of \'Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
            'Hello Instance of \'_Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
            '{Closure: (String) => dynamic from Function \'addHello\': static.(await fetchUsername())}':
                'Did you place the \'\$\' character correctly?',
            '{Closure \'addHello\'(await fetchUsername())}':
                'Did you place the \'\$\' character correctly?',
          }))
      ..add(_makeReadable4(
          testLabel: 'Part 3',
          testResult: await _asyncDidCatchException4(sayGoodbye),
          readableErrors: {
            _typoMessage4:
                '$_typoMessage4. Did you add the text \'Thanks, see you next time\'?',
            'null': '$didNotImplement sayGoodbye?',
            _noCatch4:
                'Did you remember to call logoutUser within a try/catch block?',
            'Instance of \'Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
            'Instance of \'_Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
          }))
      ..add(_makeReadable4(
          testLabel: 'Part 3',
          testResult: await _asyncEquals4(
              expected: 'Success! Thanks, see you next time',
              actual: await sayGoodbye(),
              typoKeyword: 'Success'),
          readableErrors: {
            _typoMessage4:
                '$_typoMessage4. Did you add the text \'Thanks, see you next time\'?',
            'null': '$didNotImplement sayGoodbye?',
            _noCatch4:
                'Did you remember to call logoutUser within a try/catch block?',
            'Instance of \'Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
            'Instance of \'_Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
            'Instance of \'_Exception\'':
                'CAUGHT Did you remember to return a string?',
          }))
      ..removeWhere((m) => m.contains(_passed4))
      ..toList();

    if (messages.isEmpty) {
      print('Success. All tests passed!');
    } else {
      messages.forEach(print);
    }
  } catch (e) {
    print('Tried to run solution, but received an exception: $e');
  }
}

// Test helpers.
String _makeReadable4({
  required String testResult,
  required Map<String, String> readableErrors,
  required String testLabel,
}) {
  String? readable;
  if (readableErrors.containsKey(testResult)) {
    readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else if ((testResult != _passed4) && (testResult.length < 18)) {
    readable = _typoMessage4;
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

Future<String> _asyncEquals4({
  required String expected,
  required dynamic actual,
  required String typoKeyword,
}) async {
  final strActual = actual is String ? actual : actual.toString();
  try {
    if (expected == actual) {
      return _passed4;
    } else if (strActual.contains(typoKeyword)) {
      return _typoMessage4;
    } else {
      return strActual;
    }
  } catch (e) {
    return e.toString();
  }
}

Future<String> _asyncDidCatchException4(Function fn) async {
  var caught = true;
  try {
    await fn();
  } on Exception catch (_) {
    caught = false;
  }

  if (caught == true) {
    return _passed4;
  } else {
    return _noCatch4;
  }
}

const _typoMessage4 = 'Test failed! Check for typos in your return value';
const _passed4 = 'PASSED';
const _noCatch4 = 'NO_CATCH';
const _halfSecond4 = Duration(milliseconds: 500);

String _failOnce() {
  if (_logoutSucceeds) {
    return 'Success!';
  } else {
    _logoutSucceeds = true;
    throw Exception('Logout failed');
  }
}

bool _logoutSucceeds = false;

// ===  ===  ===  ===  === 5 接收 stream 事件 ===  ===  ===  ===  ===

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  try {
    await for (final value in stream) {
      sum += value;
    }
  } catch (err) {
    return -1;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    if (i == 4) {
      throw Exception('Intentional exception'); //模拟报错
    } else {
      //print("index: $i"); 输出 1 ~ 10
      yield i; //作用类似于 return 语句;
    }
  }
}

//ToDo 24.11.11 这段逻辑不是很明白
void testStream() async {
  var stream = countStream(10);
  // print("stream: $stream"); Instance of '_ControllerStream<int>'
  var sum = await sumStream(stream);
  print("sum: $sum");
}

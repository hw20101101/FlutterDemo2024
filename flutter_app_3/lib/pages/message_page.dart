import 'package:flutter/material.dart';

//定义两个页面间传递的数据类型
class Message {
  final String title;
  final String description;

  const Message(this.title, this.description);
}

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.datas});
  final String datas; //从上个页面传递过来的数据

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    //一：修改返回到上个页面的数据
    var tempData = "10${widget.datas}";
    //二：接收上个页面传递过来的数据
    final message = ModalRoute.of(context)!.settings.arguments as Message;
    print("-->> 上个页面传递的数据：${message.title}");

    return Scaffold(
        appBar: AppBar(
          title: const Text("消息页面"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.datas, //使用从上个页面传递过来的数据
              style: const TextStyle(fontSize: 40),
            ),
            FloatingActionButton(
              onPressed: () {
                print("-->> tempData:$tempData");
                Navigator.pop(context, tempData); //返回数据给上个页面
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
          ],
        ));
  }
}

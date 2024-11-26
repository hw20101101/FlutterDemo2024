import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.datas});
  final String datas; //从上个页面传递过来的数据

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    //修改返回到上个页面的数据
    var tempData = "10${widget.datas}";

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

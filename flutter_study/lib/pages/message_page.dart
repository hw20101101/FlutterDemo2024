import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.titles});
  final String titles; //从上个页面传递过来的标题

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titles), //使用从上个页面传递过来的标题
      ),
      body: Center(
        child: Text('Message Page'),
      ),
    );
  }
}

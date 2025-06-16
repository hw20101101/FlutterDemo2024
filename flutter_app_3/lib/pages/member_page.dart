import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/address.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final TextEditingController _textController = TextEditingController();
  final _channel =
      WebSocketChannel.connect(Uri.parse('wss://echo.websocket.events'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                child: TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: "send a message"),
            )),
            const SizedBox(
              height: 24,
            ),
            // 监听来自服务器的消息
            StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  return Text(
                      snapshot.hasData ? '服务器:${snapshot.data}' : '服务器:null');
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: "send message",
        child: const Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      print("-->> _textController.text:${_textController.text}");

      //要向服务器发送数据
      _channel.sink.add(_textController.text);
    }

    testAddress();
  }

  void testAddress() {
    Address address = Address("中山大道1号", "广州");
    User3 user = User3("zhangsan", "xxxx@13.com", address);
    print(user.toJson());
  }

  @override
  void dispose() {
    _channel.sink.close();
    _textController.dispose();
    super.dispose();
  }
}

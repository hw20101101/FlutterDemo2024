import 'package:flutter/material.dart';

class MessageDetailPage extends StatefulWidget {
  const MessageDetailPage({super.key});

  @override
  State<MessageDetailPage> createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // 在页面首次渲染完成后跳转
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 计算目标位置：索引 100 × 每个 item 的高度 100
      final double targetPosition = 20 * 100.0;
      // 检查最大可滚动范围，避免越界
      final double maxScroll = _scrollController.position.maxScrollExtent;
      if (targetPosition <= maxScroll) {
        _scrollController.jumpTo(targetPosition);
      } else {
        _scrollController.jumpTo(maxScroll);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.blue,
            child: const Center(child: Text('播放器')),
          ),
          SizedBox(
            height: 400, // ListView 固定高度
            child: ListView.builder(
              controller: _scrollController,
              itemExtent: 100, // 每个 item 固定高度 100
              itemCount: 200, // 确保数据足够长（至少 101 个）
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('消息 $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<StatefulWidget> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  late Future<void> _initVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    //网络视频地址
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

    _initVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butterfly Video'),
      ),
      body: FutureBuilder(
        future: _initVideoPlayerFuture,
        builder: (context, snapshot) {
          //必须在 _initializeVideoPlayerFuture 完成后才展示 VideoPlayer 组件
          if (snapshot.connectionState == ConnectionState.done) {
            // 把 VideoPlayer 组件嵌进一个 AspectRatio 组件中，保证视频播放保持正确的比例
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            // 使用 FutureBuilder 来展示一个旋转的加载图标直到初始化完成
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ), //播放按钮
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child:
            // 根据播放状态展示播放或者暂停的图标
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}

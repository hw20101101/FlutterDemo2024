// Animation 动画

import 'package:flutter/material.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Page')),
      body: const MyFadeWidget(
        title: 'test Fade',
      ),
    );
  }
}

class MyFadeWidget extends StatefulWidget {
  const MyFadeWidget({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MyFadeWidgetState();
  }
}

class _MyFadeWidgetState extends State<MyFadeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FadeTransition(
                opacity: _curve, child: const FlutterLogo(size: 100))),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _controller.forward();
            },
            tooltip: 'Fade',
            child: const Icon(Icons.brush)));
  }
}

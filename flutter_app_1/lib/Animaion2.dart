import 'package:flutter/material.dart';

void main() {
  runApp(const LogoApp2());
}

// 修改 AnimatedLogo 来封装其 Tween 对象
class AnimatedLogo2 extends AnimatedWidget {
  const AnimatedLogo2({super.key, required Animation<double> animation})
      : super(listenable: animation);

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp2 extends StatefulWidget {
  const LogoApp2({super.key});

  @override
  State<StatefulWidget> createState() => _LogoAppState2();
}

class _LogoAppState2 extends State<LogoApp2>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo2(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

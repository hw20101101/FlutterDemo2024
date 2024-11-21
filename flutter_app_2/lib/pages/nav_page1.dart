import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/video_page.dart';

class Nav_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const VideoPlayerPage()));
      }),
    );
  }
}

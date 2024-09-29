import 'package:flutter/material.dart';

void main() {
  runApp(const TabApp());
}

class TabApp extends StatelessWidget {
  const TabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.directions_bike),
              ),
              Tab(
                icon: Icon(Icons.directions_car),
              ),
              Tab(
                icon: Icon(Icons.directions_train),
              )
            ]),
            title: const Text("Tabbar demo"),
          ),
          body: const TabBarView(children: [
            Icon(Icons.directions_bike),
            Icon(Icons.directions_car),
            Icon(Icons.directions_train),
          ]),
        ),
      ),
    );
  }
}

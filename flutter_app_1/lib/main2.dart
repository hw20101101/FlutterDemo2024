import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '汽车列表',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarListScreen(),
    );
  }
}

class CarListScreen extends StatelessWidget {
  final List<Car> cars = [
    Car(
      name: "特斯拉 Model S",
      description: "一款高性能电动汽车。",
      price: "\$99,990",
      imageUrl: "",
    ),
    Car(
      name: "宝马 M3",
      description: "运动型轿车，极致的驾驶体验。",
      price: "\$70,795",
      imageUrl: "",
    ),
    Car(
      name: "奥迪 A6",
      description: "豪华轿车，适合商务出行。",
      price: "\$54,900",
      imageUrl: "",
    ),
    // 可以添加更多汽车数据
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('汽车列表'),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(car.imageUrl),
              title: Text(car.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(car.description),
                  Text(car.price, style: TextStyle(color: Colors.green)),
                ],
              ),
              onTap: () {
                // 点击列表项后跳转到详情页面
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailScreen(car: car),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CarDetailScreen extends StatelessWidget {
  final Car car;

  CarDetailScreen({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(car.imageUrl),
            SizedBox(height: 16.0),
            Text(
              car.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(car.description),
            SizedBox(height: 8.0),
            Text(
              car.price,
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

class Car {
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  Car({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

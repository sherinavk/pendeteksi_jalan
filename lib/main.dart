import 'package:flutter/material.dart';
import 'homepage.dart'; // Mengimpor halaman utama 
import 'accelerometer.dart'; // Mengimpor halaman akselerometer 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Road Damage Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Menambahkan routing untuk navigasi antar halaman
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(), // Halaman awal (Homepage)
        '/accelerometer': (context) => AccelerometerPage(), // Halaman akselerometer
      },
    );
  }
}

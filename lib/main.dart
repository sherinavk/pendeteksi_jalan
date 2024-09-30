import 'package:flutter/material.dart';
import 'homepage.dart'; // Mengimpor homepage.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menyembunyikan label debug
      title: 'Accelerometer and Map App', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue, // Warna tema aplikasi
      ),
      home: HomePage(), // Mengarahkan ke halaman HomePage
    );
  }
}

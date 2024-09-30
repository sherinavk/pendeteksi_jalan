import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math'; // Untuk menghitung nilai total akselerasi (akar kuadrat)

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double x = 0.0, y = 0.0, z = 0.0;
  List<FlSpot> spots = [];
  double maxValue = 0.0;

  @override
  void initState() {
    super.initState();

    // Mendengarkan perubahan data akselerometer secara real-time
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        // Menghitung nilai akselerasi total menggunakan rumus pythagoras
        double totalAcceleration = sqrt(x * x + y * y + z * z);

        // Update nilai maksimum jika nilai baru lebih besar
        if (totalAcceleration > maxValue) {
          maxValue = totalAcceleration;
        }

        // Menambahkan data untuk grafik (FlSpot adalah titik pada grafik)
        spots.add(FlSpot(spots.length.toDouble(), totalAcceleration));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar menggunakan MediaQuery
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian judul dan grafik akselerometer
              Padding(
                padding: EdgeInsets.all(size.width * 0.05), // Padding responsif berdasarkan lebar layar
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ACCELEROMETER',
                      style: TextStyle(
                        fontSize: size.width * 0.06, // Ukuran teks responsif
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Container(
                      height: size.height * 0.25, // Tinggi kontainer responsif
                      padding: EdgeInsets.all(size.width * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(size.width * 0.04),
                      ),
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots, // Data grafik
                              isCurved: true, // Garis grafik yang halus
                              color: Colors.blue,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue.withOpacity(0.3),
                              ),
                            ),
                          ],
                          titlesData: FlTitlesData(show: false), // Menyembunyikan judul sumbu
                          gridData: FlGridData(show: false), // Menyembunyikan garis grid
                          borderData: FlBorderData(show: false), // Menyembunyikan batas grafik
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // Bagian tampilan nilai maksimum akselerasi
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Container(
                  height: size.height * 0.15,
                  padding: EdgeInsets.all(size.width * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(size.width * 0.04),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Maximum Value',
                          style: TextStyle(
                            fontSize: size.width * 0.05, // Ukuran teks responsif
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          '${maxValue.toStringAsFixed(2)} m/s²',
                          style: TextStyle(
                            fontSize: size.width * 0.08, // Ukuran teks responsif
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: size.height * 0.08, // Tinggi bottom bar responsif
          child: Center(
            child: Icon(Icons.home, size: size.width * 0.1, color: Colors.blue), // Ikon responsif
          ),
        ),
      ),
    );
  }
}

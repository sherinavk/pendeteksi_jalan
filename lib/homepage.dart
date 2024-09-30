import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart'

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
  double x = 0, y = 0, z = 0;
  List<FlSpot> spots = [];

  GoogleMapController? mapController;
  int _currentIndex = 0; // Menyimpan indeks tab saat ini

  final LatLng _center = const LatLng(-6.2088, 106.8456); // Lokasi Jakarta

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();

    // Mendapatkan data akselerometer secara real-time
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
        spots.add(FlSpot(spots.length.toDouble(), x)); // Menambahkan data untuk grafik
      });
    });
  }

  // Fungsi untuk menampilkan halaman sesuai dengan indeks navbar
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _buildAccelerometerWidget(); // Tab Home menampilkan widget akselerometer
      case 1:
        return _buildMapWidget(); // Tab Search menampilkan Google Maps
      case 2:
        return _buildProfileWidget(); // Tab Profile menampilkan halaman profil
      default:
        return Container();
    }
  }

  // Widget Akselerometer
  Widget _buildAccelerometerWidget() {
    return Column(
      children: [
        // Bagian Akselerometer
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Accelerometer Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Grafik dari data akselerometer menggunakan fl_chart
              Container(
                height: 150,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots, // Data grafik
                        isCurved: true,
                        color: Color.fromARGB(255, 52, 120, 255),
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Color.fromARGB(100, 0,

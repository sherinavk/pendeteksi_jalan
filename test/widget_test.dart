import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pendeteksi_jalan/main.dart'; // Mengimpor MyApp dari file utama

void main() {
  testWidgets('Test HomePage widgets', (WidgetTester tester) async {
    // Membangun widget MyApp (berisi HomePage)
    await tester.pumpWidget(MyApp());

    // Memastikan widget yang berisi 'Grafik Akselerometer' ada
    expect(find.text('Grafik Akselerometer'), findsOneWidget);

    // Memastikan bahwa Google Map ditampilkan
    expect(find.byType(GoogleMap), findsOneWidget);

    // Memastikan bahwa grafik FlChart ditampilkan
    expect(find.byType(LineChart), findsOneWidget);

    // Memastikan grafik di halaman akselerometer menampilkan data dengan beberapa FlSpots
    await tester.pumpAndSettle();
    expect(find.byType(LineChartBarData), findsWidgets);

    // Menguji apakah navigasi antara halaman berjalan
    await tester.tap(find.byIcon(Icons.home)); // Tap tab Home (ikon rumah)
    await tester.pumpAndSettle(); // Menunggu animasi atau update
    expect(find.text('Grafik Akselerometer'), findsOneWidget); // Memastikan kembali ke halaman akselerometer
  });
}

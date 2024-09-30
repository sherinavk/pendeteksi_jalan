import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:pendeteksi_jalan/main.dart'; // ganti dengan path file utama

void main() {
  testWidgets('Test HomePage widgets', (WidgetTester tester) async {
    // Membangun HomePage widget
    await tester.pumpWidget(MyApp());

    // Memastikan widget yang berisi 'Accelerometer Data' ada
    expect(find.text('Accelerometer Data'), findsOneWidget);

    // Memastikan ada widget yang menggunakan Google Maps
    expect(find.byType(GoogleMap), findsOneWidget);

    // Memastikan grafik FlChart ditampilkan
    expect(find.byType(LineChart), findsOneWidget);

    // Memastikan Floating Action Button ada dan ikonnya benar
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Memastikan Google Map ada dan diinisialisasi
    expect(find.byType(GoogleMap), findsOneWidget);

    // Memastikan bahwa grafik menunjukkan data
    await tester.pumpAndSettle();
    expect(find.byType(LineChartBarData), findsWidgets);

    // Simulasi tap pada FloatingActionButton (bisa diisi aksi lain untuk uji fungsi)
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Memproses aksi tap
  });
}

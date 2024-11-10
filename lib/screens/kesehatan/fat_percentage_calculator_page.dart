import 'package:flutter/material.dart';

class FatPercentageCalculatorPage extends StatefulWidget {
  final Color color;

  FatPercentageCalculatorPage({required this.color});
  @override
  _FatPercentageCalculatorPageState createState() =>
      _FatPercentageCalculatorPageState();
}

class _FatPercentageCalculatorPageState
    extends State<FatPercentageCalculatorPage> {
  final TextEditingController waistController = TextEditingController();
  final TextEditingController neckController = TextEditingController();
  final TextEditingController hipController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String fatPercentageResult = '';

  void calculateFatPercentage() {
    double waist = double.tryParse(waistController.text) ?? 0;
    double neck = double.tryParse(neckController.text) ?? 0;
    double hip = double.tryParse(hipController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    if (waist > 0 && neck > 0 && height > 0) {
      // Formula for male body fat percentage
      double bodyFat = 495 / (1.29579 - 0.35004 * (waist - neck)) - 450;
      setState(() {
        fatPercentageResult =
            'Persentase Lemak Tubuh: ${bodyFat.toStringAsFixed(2)}%';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perhitungan Persentase Lemak Tubuh'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: waistController,
              decoration: InputDecoration(labelText: 'Lingkar Pinggang (cm)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: neckController,
              decoration: InputDecoration(labelText: 'Lingkar Leher (cm)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: hipController,
              decoration: InputDecoration(labelText: 'Lingkar Pinggul (cm)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Tinggi Badan (cm)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateFatPercentage,
              child: Text('Hitung Persentase Lemak Tubuh'),
            ),
            SizedBox(height: 20),
            Text(fatPercentageResult),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HydrationCalculatorPage extends StatefulWidget {
  final Color color;

  HydrationCalculatorPage({required this.color});
  @override
  _HydrationCalculatorPageState createState() =>
      _HydrationCalculatorPageState();
}

class _HydrationCalculatorPageState extends State<HydrationCalculatorPage> {
  final TextEditingController weightController = TextEditingController();
  String hydrationResult = '';

  void calculateHydration() {
    double weight = double.tryParse(weightController.text) ?? 0;
    if (weight > 0) {
      double waterRequired = weight * 30; // 30 ml per kg of body weight
      setState(() {
        hydrationResult =
            'Kebutuhan air: ${waterRequired.toStringAsFixed(2)} ml/hari';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perhitungan Kebutuhan Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Berat Badan (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateHydration,
              child: Text('Hitung Kebutuhan Air'),
            ),
            SizedBox(height: 20),
            Text(hydrationResult),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TDEECalculatorPage extends StatefulWidget {
  final Color color;

  TDEECalculatorPage({required this.color});
  @override
  _TDEECalculatorPageState createState() => _TDEECalculatorPageState();
}

class _TDEECalculatorPageState extends State<TDEECalculatorPage> {
  final TextEditingController bmrController = TextEditingController();
  String tdeeResult = '';
  double activityFactor = 1.2;

  void calculateTDEE() {
    double bmr = double.tryParse(bmrController.text) ?? 0;
    if (bmr > 0) {
      double tdee = bmr * activityFactor;
      setState(() {
        tdeeResult = 'TDEE: ${tdee.toStringAsFixed(2)} Kcal/day';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perhitungan TDEE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: bmrController,
              decoration: InputDecoration(labelText: 'BMR (Kcal/day)'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<double>(
              value: activityFactor,
              items: [
                DropdownMenuItem(
                  child: Text('Sedentary (1.2)'),
                  value: 1.2,
                ),
                DropdownMenuItem(
                  child: Text('Ringan (1.375)'),
                  value: 1.375,
                ),
                DropdownMenuItem(
                  child: Text('Sedang (1.55)'),
                  value: 1.55,
                ),
                DropdownMenuItem(
                  child: Text('Berat (1.725)'),
                  value: 1.725,
                ),
                DropdownMenuItem(
                  child: Text('Sangat Berat (1.9)'),
                  value: 1.9,
                ),
              ],
              onChanged: (value) {
                setState(() {
                  activityFactor = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: calculateTDEE,
              child: Text('Hitung TDEE'),
            ),
            SizedBox(height: 20),
            Text(tdeeResult),
          ],
        ),
      ),
    );
  }
}

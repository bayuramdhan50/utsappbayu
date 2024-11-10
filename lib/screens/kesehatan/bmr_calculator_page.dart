import 'package:flutter/material.dart';

class BMRCalculatorPage extends StatefulWidget {
  final Color color;

  BMRCalculatorPage({required this.color});
  @override
  _BMRCalculatorPageState createState() => _BMRCalculatorPageState();
}

class _BMRCalculatorPageState extends State<BMRCalculatorPage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String bmrResult = '';
  bool isMale = true;

  void calculateBMR() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;
    int age = int.tryParse(ageController.text) ?? 0;
    double bmr = 0;

    if (weight > 0 && height > 0 && age > 0) {
      if (isMale) {
        bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
      } else {
        bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
      }
      setState(() {
        bmrResult = 'BMR: ${bmr.toStringAsFixed(2)} Kcal/day';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perhitungan BMR'),
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
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Tinggi Badan (cm)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Usia (tahun)'),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pria'),
                Radio(
                  value: true,
                  groupValue: isMale,
                  onChanged: (bool? value) {
                    setState(() {
                      isMale = value!;
                    });
                  },
                ),
                Text('Wanita'),
                Radio(
                  value: false,
                  groupValue: isMale,
                  onChanged: (bool? value) {
                    setState(() {
                      isMale = value!;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: calculateBMR,
              child: Text('Hitung BMR'),
            ),
            SizedBox(height: 20),
            Text(bmrResult),
          ],
        ),
      ),
    );
  }
}

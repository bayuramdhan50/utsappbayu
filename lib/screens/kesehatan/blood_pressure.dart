import 'package:flutter/material.dart';

class BloodPressurePage extends StatefulWidget {
  final Color color;
  BloodPressurePage({required this.color});

  @override
  _BloodPressurePageState createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  String _result = '';

  void _calculateBloodPressure() {
    int systolic = int.tryParse(_systolicController.text) ?? 0;
    int diastolic = int.tryParse(_diastolicController.text) ?? 0;

    if (systolic == 0 || diastolic == 0) {
      setState(() {
        _result = 'Masukkan nilai tekanan darah yang valid';
      });
    } else {
      if (systolic < 120 && diastolic < 80) {
        _result = 'Tekanan Darah Normal';
      } else if (systolic <= 129 && diastolic < 80) {
        _result = 'Elevated (Tekanan Darah Tinggi Ringan)';
      } else if (systolic <= 139 || diastolic <= 89) {
        _result = 'Hipertensi Tahap 1';
      } else {
        _result = 'Hipertensi Tahap 2';
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Tekanan Darah'), backgroundColor: widget.color),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _systolicController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Sistolik (Tekanan Atas)'),
            ),
            TextField(
              controller: _diastolicController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Diastolik (Tekanan Bawah)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBloodPressure,
              child: Text('Hitung'),
              style: ElevatedButton.styleFrom(backgroundColor: widget.color),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

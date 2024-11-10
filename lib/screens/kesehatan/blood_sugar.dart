import 'package:flutter/material.dart';

class BloodSugarPage extends StatefulWidget {
  final Color color;
  BloodSugarPage({required this.color});

  @override
  _BloodSugarPageState createState() => _BloodSugarPageState();
}

class _BloodSugarPageState extends State<BloodSugarPage> {
  final _inputController = TextEditingController();
  String _result = '';

  void _calculateBloodSugar() {
    double bloodSugar = double.tryParse(_inputController.text) ?? 0;
    if (bloodSugar == 0) {
      setState(() {
        _result = 'Masukkan nilai gula darah yang valid';
      });
    } else {
      if (bloodSugar < 70) {
        _result = 'Hipoglikemia (Gula darah rendah)';
      } else if (bloodSugar <= 100) {
        _result = 'Normal';
      } else if (bloodSugar <= 125) {
        _result = 'Prediabetes';
      } else {
        _result = 'Diabetes';
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gula Darah'), backgroundColor: widget.color),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Masukkan Gula Darah (mg/dL)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBloodSugar,
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

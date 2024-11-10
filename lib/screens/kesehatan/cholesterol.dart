import 'package:flutter/material.dart';

class CholesterolPage extends StatefulWidget {
  final Color color;
  CholesterolPage({required this.color});

  @override
  _CholesterolPageState createState() => _CholesterolPageState();
}

class _CholesterolPageState extends State<CholesterolPage> {
  final _inputController = TextEditingController();
  String _result = '';

  void _calculateCholesterol() {
    double cholesterol = double.tryParse(_inputController.text) ?? 0;
    if (cholesterol == 0) {
      setState(() {
        _result = 'Masukkan nilai kolesterol yang valid';
      });
    } else {
      if (cholesterol < 200) {
        _result = 'Kolesterol Normal';
      } else if (cholesterol <= 239) {
        _result = 'Tinggi sedang';
      } else {
        _result = 'Kolesterol Tinggi';
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kolesterol'), backgroundColor: widget.color),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Masukkan Kolesterol (mg/dL)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateCholesterol,
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

import 'package:flutter/material.dart';

class StepsCountPage extends StatefulWidget {
  final Color color;
  StepsCountPage({required this.color});

  @override
  _StepsCountPageState createState() => _StepsCountPageState();
}

class _StepsCountPageState extends State<StepsCountPage> {
  final _inputController = TextEditingController();
  String _result = '';

  void _calculateSteps() {
    int steps = int.tryParse(_inputController.text) ?? 0;

    if (steps == 0) {
      setState(() {
        _result = 'Masukkan jumlah langkah yang valid';
      });
    } else {
      if (steps < 5000) {
        _result = 'Sedikit aktivitas fisik';
      } else if (steps < 10000) {
        _result = 'Aktivitas fisik cukup baik';
      } else {
        _result = 'Aktivitas fisik sangat baik';
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Jumlah Langkah Harian'), backgroundColor: widget.color),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Masukkan Jumlah Langkah'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateSteps,
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

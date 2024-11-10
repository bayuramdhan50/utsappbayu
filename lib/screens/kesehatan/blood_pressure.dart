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
      body: Stack(
        children: [
          Container(color: widget.color),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTextField(
                            'Sistolik (Tekanan Atas)', _systolicController),
                        SizedBox(height: 20),
                        _buildTextField(
                            'Diastolik (Tekanan Bawah)', _diastolicController),
                        SizedBox(height: 20),
                        _buildCalculateButton(),
                        SizedBox(height: 20),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10),
                        _buildResultText(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: _calculateBloodPressure,
      child: Text('Hitung',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: widget.color,
      ),
    );
  }

  Widget _buildResultText() {
    return Text(
      _result,
      style: TextStyle(fontSize: 24, color: Colors.blueAccent),
      textAlign: TextAlign.center,
    );
  }
}

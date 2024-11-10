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
                            'Masukkan Gula Darah (mg/dL)', _inputController),
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
      onPressed: _calculateBloodSugar,
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

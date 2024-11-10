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
        backgroundColor: widget.color,
      ),
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
                            'Lingkar Pinggang (cm)', waistController),
                        SizedBox(height: 20),
                        _buildTextField('Lingkar Leher (cm)', neckController),
                        SizedBox(height: 20),
                        _buildTextField('Lingkar Pinggul (cm)', hipController),
                        SizedBox(height: 20),
                        _buildTextField('Tinggi Badan (cm)', heightController),
                        SizedBox(height: 20),
                        _buildCalculateButton(),
                        SizedBox(height: 20),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10),
                        _buildFatPercentageResult(),
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
      onPressed: calculateFatPercentage,
      child: Text('Hitung Persentase Lemak Tubuh',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: widget.color,
      ),
    );
  }

  Widget _buildFatPercentageResult() {
    return Text(
      fatPercentageResult,
      style: TextStyle(fontSize: 24, color: Colors.blueAccent),
      textAlign: TextAlign.center,
    );
  }
}

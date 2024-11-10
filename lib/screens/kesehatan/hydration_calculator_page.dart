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
                        _buildTextField('Berat Badan (kg)', weightController),
                        SizedBox(height: 20),
                        _buildCalculateButton(),
                        SizedBox(height: 20),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10),
                        _buildHydrationResult(),
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
      onPressed: calculateHydration,
      child: Text('Hitung Kebutuhan Air',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: widget.color,
      ),
    );
  }

  Widget _buildHydrationResult() {
    return Text(
      hydrationResult,
      style: TextStyle(fontSize: 24, color: Colors.blueAccent),
      textAlign: TextAlign.center,
    );
  }
}

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
                        _buildTextField('BMR (Kcal/day)', bmrController),
                        SizedBox(height: 20),
                        _buildActivityDropdown(),
                        SizedBox(height: 20),
                        _buildCalculateButton(),
                        SizedBox(height: 20),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10),
                        _buildTDEEResult(),
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

  Widget _buildActivityDropdown() {
    return DropdownButton<double>(
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
      isExpanded: true,
      iconSize: 30,
      underline: Container(),
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: calculateTDEE,
      child: Text('Hitung TDEE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: widget.color,
      ),
    );
  }

  Widget _buildTDEEResult() {
    return Text(
      tdeeResult,
      style: TextStyle(fontSize: 24, color: Colors.blueAccent),
      textAlign: TextAlign.center,
    );
  }
}

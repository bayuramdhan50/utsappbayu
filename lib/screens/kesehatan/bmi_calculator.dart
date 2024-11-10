import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  final Color color;

  BMICalculator({required this.color});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String _result = '';
  String _description = '';
  String _gender = 'Male'; // default gender selection

  void _calculateBMI() {
    final double heightCm = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    // Convert height from cm to meters
    final double height = heightCm / 100;

    if (height > 0 && weight > 0) {
      double bmi = weight / (height * height);

      setState(() {
        _result = 'BMI: ${bmi.toStringAsFixed(2)}';
        _description = _getBMIDescription(bmi);
      });
    }
  }

  String _getBMIDescription(double bmi) {
    // BMI categories based on WHO standards
    if (bmi < 18.5) {
      return 'Underweight: Berat badan kurang. Disarankan untuk menambah asupan kalori sehat.';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal: Berat badan ideal. Pertahankan gaya hidup sehat!';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight: Berat badan berlebih. Sebaiknya perhatikan pola makan dan aktivitas fisik.';
    } else {
      return 'Obese: Obesitas. Disarankan untuk berkonsultasi dengan profesional kesehatan.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator BMI'),
        backgroundColor: widget.color,
      ),
      body: Stack(
        children: [
          Container(
            color: widget.color,
          ),
          Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Gender: "),
                          Radio<String>(
                            value: 'Male',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          Text("Male"),
                          Radio<String>(
                            value: 'Female',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          Text("Female"),
                        ],
                      ),
                      TextField(
                        controller: _heightController,
                        decoration: InputDecoration(
                          labelText: 'Tinggi (cm)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _weightController,
                        decoration: InputDecoration(
                          labelText: 'Berat (kg)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _calculateBMI,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.color,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Hitung BMI',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        _result,
                        style: TextStyle(fontSize: 24, color: widget.color),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _description,
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

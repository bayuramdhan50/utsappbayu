import 'package:flutter/material.dart';

class SpeedConversionPage extends StatefulWidget {
  final Color color;

  SpeedConversionPage({required this.color});

  @override
  _SpeedConversionPageState createState() => _SpeedConversionPageState();
}

class _SpeedConversionPageState extends State<SpeedConversionPage> {
  final _inputController = TextEditingController();
  String _convertedValue = '';
  String _selectedFromUnit = 'Meter per second';
  String _selectedToUnit = 'Kilometer per hour';

  final List<String> _units = [
    'Meter per second',
    'Kilometer per hour',
    'Mile per hour',
    'Foot per second'
  ];

  void _convertSpeed() {
    double input = double.tryParse(_inputController.text) ?? 0;
    if (input == 0) {
      setState(() {
        _convertedValue = 'Input tidak valid';
      });
      return;
    }

    double convertedValue = 0;
    switch (_selectedFromUnit) {
      case 'Kilometer per hour':
        input /= 3.6;
        break;
      case 'Mile per hour':
        input /= 2.23694;
        break;
      case 'Foot per second':
        input /= 3.28084;
        break;
      default:
        break;
    }

    switch (_selectedToUnit) {
      case 'Kilometer per hour':
        convertedValue = input * 3.6;
        break;
      case 'Mile per hour':
        convertedValue = input * 2.23694;
        break;
      case 'Foot per second':
        convertedValue = input * 3.28084;
        break;
      default:
        convertedValue = input;
        break;
    }

    setState(() {
      _convertedValue = '$convertedValue $_selectedToUnit';
    });
  }

  void _swapUnits() {
    setState(() {
      String temp = _selectedFromUnit;
      _selectedFromUnit = _selectedToUnit;
      _selectedToUnit = temp;
    });
    _convertSpeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Kecepatan'),
        backgroundColor: widget.color,
      ),
      body: Stack(
        children: [
          Container(color: widget.color),
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
                      _buildTextField('Masukkan kecepatan', _inputController),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildDropdown(
                                'Unit Sumber', _selectedFromUnit, (newValue) {
                              setState(() {
                                _selectedFromUnit = newValue!;
                                _convertSpeed();
                              });
                            }),
                          ),
                          IconButton(
                            icon: Icon(Icons.swap_horiz,
                                color: Colors.blueAccent),
                            onPressed: _swapUnits,
                          ),
                          Expanded(
                            child: _buildDropdown(
                                'Unit Tujuan', _selectedToUnit, (newValue) {
                              setState(() {
                                _selectedToUnit = newValue!;
                                _convertSpeed();
                              });
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildConvertButton(),
                      SizedBox(height: 20),
                      Divider(color: Colors.grey),
                      SizedBox(height: 10),
                      _buildConvertedValue(),
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
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

  Widget _buildDropdown(
      String label, String selectedValue, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: _units
          .map((unit) => DropdownMenuItem(value: unit, child: Text(unit)))
          .toList(),
      isExpanded: true,
      underline: SizedBox(),
    );
  }

  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertSpeed,
      child: Text('Konversi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: widget.color,
      ),
    );
  }

  Widget _buildConvertedValue() {
    return Text(
      _convertedValue,
      style: TextStyle(fontSize: 24, color: Colors.blueAccent),
      textAlign: TextAlign.center,
    );
  }
}

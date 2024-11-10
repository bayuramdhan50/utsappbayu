import 'package:flutter/material.dart';

class VolumeConversionPage extends StatefulWidget {
  final Color color;

  VolumeConversionPage({required this.color});

  @override
  _VolumeConversionPageState createState() => _VolumeConversionPageState();
}

class _VolumeConversionPageState extends State<VolumeConversionPage> {
  final _inputController = TextEditingController();
  String _convertedValue = '';
  String _selectedFromUnit = 'Liter';
  String _selectedToUnit = 'Milliliter';

  final List<String> _units = [
    'Liter',
    'Milliliter',
    'Cubic Meter',
    'Cubic Centimeter',
    'Gallon',
    'Fluid Ounce'
  ];

  void _convertVolume() {
    double input = double.tryParse(_inputController.text) ?? 0;
    if (input == 0) {
      setState(() {
        _convertedValue = 'Input tidak valid';
      });
      return;
    }

    double convertedValue = 0;
    switch (_selectedFromUnit) {
      case 'Milliliter':
        input /= 1000;
        break;
      case 'Cubic Meter':
        input *= 1000;
        break;
      case 'Cubic Centimeter':
        input /= 1000;
        break;
      case 'Gallon':
        input *= 3.78541;
        break;
      case 'Fluid Ounce':
        input *= 0.0295735;
        break;
      default:
        break;
    }

    switch (_selectedToUnit) {
      case 'Milliliter':
        convertedValue = input * 1000;
        break;
      case 'Cubic Meter':
        convertedValue = input / 1000;
        break;
      case 'Cubic Centimeter':
        convertedValue = input * 1000;
        break;
      case 'Gallon':
        convertedValue = input / 3.78541;
        break;
      case 'Fluid Ounce':
        convertedValue = input / 0.0295735;
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
    _convertVolume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Volume'),
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
                      _buildTextField('Masukkan volume', _inputController),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildDropdown(
                                'Unit Sumber', _selectedFromUnit, (newValue) {
                              setState(() {
                                _selectedFromUnit = newValue!;
                                _convertVolume();
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
                                _convertVolume();
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
      onPressed: _convertVolume,
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

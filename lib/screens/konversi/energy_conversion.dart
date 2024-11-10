import 'package:flutter/material.dart';

class EnergyConversionPage extends StatefulWidget {
  final Color color;

  EnergyConversionPage({required this.color});

  @override
  _EnergyConversionPageState createState() => _EnergyConversionPageState();
}

class _EnergyConversionPageState extends State<EnergyConversionPage> {
  final _inputController = TextEditingController();
  String _convertedValue = '';
  String _selectedFromUnit = 'Joule';
  String _selectedToUnit = 'Kilojoule';

  final List<String> _units = [
    'Joule',
    'Kilojoule',
    'Calorie',
    'Kilocalorie',
    'Watt-hour',
    'Kilowatt-hour'
  ];

  void _convertEnergy() {
    double input = double.tryParse(_inputController.text) ?? 0;
    if (input == 0) {
      setState(() {
        _convertedValue = 'Input tidak valid';
      });
      return;
    }

    double convertedValue = 0;
    switch (_selectedFromUnit) {
      case 'Kilojoule':
        input *= 1000;
        break;
      case 'Calorie':
        input *= 4.184;
        break;
      case 'Kilocalorie':
        input *= 4184;
        break;
      case 'Watt-hour':
        input *= 3600;
        break;
      case 'Kilowatt-hour':
        input *= 3600000;
        break;
      default:
        break;
    }

    switch (_selectedToUnit) {
      case 'Kilojoule':
        convertedValue = input / 1000;
        break;
      case 'Calorie':
        convertedValue = input / 4.184;
        break;
      case 'Kilocalorie':
        convertedValue = input / 4184;
        break;
      case 'Watt-hour':
        convertedValue = input / 3600;
        break;
      case 'Kilowatt-hour':
        convertedValue = input / 3600000;
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
    _convertEnergy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Energi'),
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
                      _buildTextField('Masukkan energi', _inputController),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildDropdown(
                                'Unit Sumber', _selectedFromUnit, (newValue) {
                              setState(() {
                                _selectedFromUnit = newValue!;
                                _convertEnergy();
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
                                _convertEnergy();
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
      onPressed: _convertEnergy,
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

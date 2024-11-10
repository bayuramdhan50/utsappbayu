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
      appBar:
          AppBar(title: Text('Konversi Volume'), backgroundColor: widget.color),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField('Masukkan volume', _inputController),
            SizedBox(height: 16),
            _buildDropdown('Unit Sumber', _selectedFromUnit, (newValue) {
              setState(() {
                _selectedFromUnit = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildSwapButton(),
            SizedBox(height: 16),
            _buildDropdown('Unit Tujuan', _selectedToUnit, (newValue) {
              setState(() {
                _selectedToUnit = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildConvertButton(),
            SizedBox(height: 16),
            _buildConvertedValue(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200]),
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

  Widget _buildSwapButton() {
    return ElevatedButton(
      onPressed: _swapUnits,
      child: Icon(Icons.swap_horiz),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          backgroundColor: Colors.green),
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
    return Text(_convertedValue,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }
}

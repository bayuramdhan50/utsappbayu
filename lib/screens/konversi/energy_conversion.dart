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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField('Masukkan energi', _inputController),
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
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildDropdown(
      String label, String selectedValue, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: _units.map((unit) {
        return DropdownMenuItem(
          value: unit,
          child: Text(unit),
        );
      }).toList(),
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
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertEnergy,
      child: Text(
        'Konversi',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
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
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

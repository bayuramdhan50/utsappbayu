import 'package:flutter/material.dart';

class LengthConversionPage extends StatefulWidget {
  final Color color;

  LengthConversionPage({required this.color});
  @override
  _LengthConversionPageState createState() => _LengthConversionPageState();
}

class _LengthConversionPageState extends State<LengthConversionPage> {
  final _inputController = TextEditingController();
  String _convertedValue = '';
  String _selectedFromUnit = 'Meter';
  String _selectedToUnit = 'Kilometer';

  final List<String> _units = [
    'Meter',
    'Kilometer',
    'Centimeter',
    'Millimeter',
    'Inch',
    'Foot',
    'Yard',
    'Mile'
  ];

  void _convertLength() {
    double input = double.tryParse(_inputController.text) ?? 0;
    if (input == 0) {
      setState(() {
        _convertedValue = 'Input tidak valid';
      });
      return;
    }

    double convertedValue = 0;

    switch (_selectedFromUnit) {
      case 'Kilometer':
        input *= 1000;
        break;
      case 'Centimeter':
        input /= 100;
        break;
      case 'Millimeter':
        input /= 1000;
        break;
      case 'Inch':
        input *= 0.0254;
        break;
      case 'Foot':
        input *= 0.3048;
        break;
      case 'Yard':
        input *= 0.9144;
        break;
      case 'Mile':
        input *= 1609.34;
        break;
      default:
        break;
    }

    switch (_selectedToUnit) {
      case 'Kilometer':
        convertedValue = input / 1000;
        break;
      case 'Centimeter':
        convertedValue = input * 100;
        break;
      case 'Millimeter':
        convertedValue = input * 1000;
        break;
      case 'Inch':
        convertedValue = input / 0.0254;
        break;
      case 'Foot':
        convertedValue = input / 0.3048;
        break;
      case 'Yard':
        convertedValue = input / 0.9144;
        break;
      case 'Mile':
        convertedValue = input / 1609.34;
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
    _convertLength();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Panjang'),
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
                      TextField(
                        controller: _inputController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan panjang (${_selectedFromUnit})',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              value: _selectedFromUnit,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedFromUnit = newValue!;
                                  _convertLength();
                                });
                              },
                              items: _units.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.swap_horiz,
                                color: Colors.blueAccent),
                            onPressed: _swapUnits,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: _selectedToUnit,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedToUnit = newValue!;
                                  _convertLength();
                                });
                              },
                              items: _units.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _convertLength,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.color,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Konversi', style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        _convertedValue,
                        style:
                            TextStyle(fontSize: 24, color: Colors.blueAccent),
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

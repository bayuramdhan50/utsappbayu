import 'package:flutter/material.dart';

class TemperatureConverter extends StatefulWidget {
  final Color color;

  TemperatureConverter({required this.color});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final _temperatureController = TextEditingController();
  String _result = '';
  String _description = '';
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';

  void _convertTemperature() {
    final double temperature =
        double.tryParse(_temperatureController.text) ?? 0;
    double convertedTemperature = 0;

    // Mengonversi suhu sesuai dengan pilihan satuan asal dan tujuan
    if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
      convertedTemperature = (temperature * 9 / 5) + 32;
    } else if (_fromUnit == 'Celsius' && _toUnit == 'Kelvin') {
      convertedTemperature = temperature + 273.15;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
      convertedTemperature = (temperature - 32) * 5 / 9;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Kelvin') {
      convertedTemperature = (temperature - 32) * 5 / 9 + 273.15;
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Celsius') {
      convertedTemperature = temperature - 273.15;
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Fahrenheit') {
      convertedTemperature = (temperature - 273.15) * 9 / 5 + 32;
    } else {
      // Jika satuan asal dan tujuan sama
      convertedTemperature = temperature;
    }

    setState(() {
      _result = 'Hasil: ${convertedTemperature.toStringAsFixed(2)} °$_toUnit';
      _description = _getTemperatureDescription(temperature, _fromUnit);
    });
  }

  String _getTemperatureDescription(double temp, String unit) {
    double tempInCelsius;

    // Konversi suhu ke Celsius untuk evaluasi kategori suhu
    if (unit == 'Celsius') {
      tempInCelsius = temp;
    } else if (unit == 'Fahrenheit') {
      tempInCelsius = (temp - 32) * 5 / 9;
    } else {
      tempInCelsius = temp - 273.15;
    }

    // Tentukan keterangan berdasarkan rentang suhu
    if (tempInCelsius < 15) {
      return 'Dingin';
    } else if (tempInCelsius >= 15 && tempInCelsius <= 30) {
      return 'Normal';
    } else {
      return 'Panas';
    }
  }

  void _swapUnits() {
    setState(() {
      String temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _convertTemperature();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu'),
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
                        controller: _temperatureController,
                        decoration: InputDecoration(
                          labelText: 'Suhu (${_fromUnit})',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Dropdown untuk memilih satuan asal
                          Expanded(
                            child: DropdownButton<String>(
                              value: _fromUnit,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _fromUnit = newValue!;
                                  _convertTemperature();
                                });
                              },
                              items: [
                                'Celsius',
                                'Fahrenheit',
                                'Kelvin'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.swap_horiz,
                                color: Colors.blueAccent),
                            onPressed: _swapUnits,
                          ),
                          // Dropdown untuk memilih satuan tujuan
                          Expanded(
                            child: DropdownButton<String>(
                              value: _toUnit,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _toUnit = newValue!;
                                  _convertTemperature();
                                });
                              },
                              items: [
                                'Celsius',
                                'Fahrenheit',
                                'Kelvin'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _convertTemperature,
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
                      Text(
                        _result,
                        style:
                            TextStyle(fontSize: 24, color: Colors.blueAccent),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _description,
                        style:
                            TextStyle(fontSize: 20, color: Colors.blueAccent),
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

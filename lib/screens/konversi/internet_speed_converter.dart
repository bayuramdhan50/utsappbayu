import 'package:flutter/material.dart';

class InternetSpeedConverter extends StatefulWidget {
  final Color color;

  InternetSpeedConverter({required this.color});

  @override
  _InternetSpeedConverterState createState() => _InternetSpeedConverterState();
}

class _InternetSpeedConverterState extends State<InternetSpeedConverter> {
  final _inputController = TextEditingController();
  double _output = 0.0;
  String _fromUnit = 'Mbps';
  String _toUnit = 'Kbps';

  // Fungsi untuk konversi kecepatan
  void _convert() {
    double inputValue = double.tryParse(_inputController.text) ?? 0.0;

    if (_fromUnit == 'Mbps' && _toUnit == 'Kbps') {
      _output = inputValue * 1000;
    } else if (_fromUnit == 'Mbps' && _toUnit == 'Gbps') {
      _output = inputValue / 1000;
    } else if (_fromUnit == 'Mbps' && _toUnit == 'MBps') {
      _output = inputValue / 8; // 1 Mbps = 0.125 MBps
    } else if (_fromUnit == 'Mbps' && _toUnit == 'KBps') {
      _output = inputValue * 125; // 1 Mbps = 125 KBps
    } else if (_fromUnit == 'Mbps' && _toUnit == 'GBps') {
      _output = inputValue / 8000; // 1 Mbps = 0.000125 GBps
    } else if (_fromUnit == 'Kbps' && _toUnit == 'Mbps') {
      _output = inputValue / 1000;
    } else if (_fromUnit == 'Kbps' && _toUnit == 'Gbps') {
      _output = inputValue / 1000000;
    } else if (_fromUnit == 'Kbps' && _toUnit == 'MBps') {
      _output = inputValue / 8000; // 1 Kbps = 0.125 KBps
    } else if (_fromUnit == 'Kbps' && _toUnit == 'KBps') {
      _output = inputValue / 8; // 1 Kbps = 0.125 KBps
    } else if (_fromUnit == 'Kbps' && _toUnit == 'GBps') {
      _output = inputValue / 8000000; // 1 Kbps = 0.000125 GBps
    } else if (_fromUnit == 'Gbps' && _toUnit == 'Mbps') {
      _output = inputValue * 1000;
    } else if (_fromUnit == 'Gbps' && _toUnit == 'Kbps') {
      _output = inputValue * 1000000;
    } else if (_fromUnit == 'Gbps' && _toUnit == 'MBps') {
      _output = inputValue * 125; // 1 Gbps = 125 MBps
    } else if (_fromUnit == 'Gbps' && _toUnit == 'KBps') {
      _output = inputValue * 125000; // 1 Gbps = 125000 KBps
    } else if (_fromUnit == 'Gbps' && _toUnit == 'GBps') {
      _output = inputValue * 125; // 1 Gbps = 125 GBps
    } else if (_fromUnit == 'MBps' && _toUnit == 'Mbps') {
      _output = inputValue * 8; // 1 MBps = 8 Mbps
    } else if (_fromUnit == 'MBps' && _toUnit == 'Kbps') {
      _output = inputValue * 8000; // 1 MBps = 8000 Kbps
    } else if (_fromUnit == 'MBps' && _toUnit == 'Gbps') {
      _output = inputValue / 125; // 1 MBps = 0.008 Gbps
    } else if (_fromUnit == 'MBps' && _toUnit == 'GBps') {
      _output = inputValue / 1024; // 1 MBps = 0.000976 GBps
    } else if (_fromUnit == 'KBps' && _toUnit == 'Mbps') {
      _output = inputValue / 125; // 1 KBps = 0.008 Mbps
    } else if (_fromUnit == 'KBps' && _toUnit == 'Kbps') {
      _output = inputValue * 8; // 1 KBps = 8 Kbps
    } else if (_fromUnit == 'KBps' && _toUnit == 'Gbps') {
      _output = inputValue / 125000; // 1 KBps = 0.000008 Gbps
    } else if (_fromUnit == 'KBps' && _toUnit == 'GBps') {
      _output = inputValue / 125000; // 1 KBps = 0.000008 GBps
    } else if (_fromUnit == 'GBps' && _toUnit == 'Mbps') {
      _output = inputValue * 8000; // 1 GBps = 8000 Mbps
    } else if (_fromUnit == 'GBps' && _toUnit == 'Kbps') {
      _output = inputValue * 8000000; // 1 GBps = 8000000 Kbps
    } else if (_fromUnit == 'GBps' && _toUnit == 'Gbps') {
      _output = inputValue * 8; // 1 GBps = 8 Gbps
    } else if (_fromUnit == 'GBps' && _toUnit == 'MBps') {
      _output = inputValue * 1024; // 1 GBps = 1024 MBps
    } else {
      _output = inputValue; // Jika unit sama
    }

    setState(() {});
  }

  // Fungsi untuk membalikkan unit
  void _reverseUnits() {
    setState(() {
      String temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Kecepatan Internet'),
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
                          labelText: 'Masukkan Nilai ($_fromUnit)',
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
                          // Dropdown untuk memilih unit asal
                          Expanded(
                            child: DropdownButton<String>(
                              value: _fromUnit,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _fromUnit = newValue!;
                                  _convert();
                                });
                              },
                              items: [
                                'Mbps',
                                'Kbps',
                                'Gbps',
                                'MBps',
                                'KBps',
                                'GBps'
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
                            onPressed: _reverseUnits,
                          ),
                          // Dropdown untuk memilih unit tujuan
                          Expanded(
                            child: DropdownButton<String>(
                              value: _toUnit,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _toUnit = newValue!;
                                  _convert();
                                });
                              },
                              items: [
                                'Mbps',
                                'Kbps',
                                'Gbps',
                                'MBps',
                                'KBps',
                                'GBps'
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
                      Text(
                        'Hasil: $_output $_toUnit',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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

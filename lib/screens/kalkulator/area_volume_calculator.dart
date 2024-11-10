import 'package:flutter/material.dart';

class AreaVolumeCalculator extends StatefulWidget {
  final Color color;

  AreaVolumeCalculator({required this.color});

  @override
  _AreaVolumeCalculatorState createState() => _AreaVolumeCalculatorState();
}

class _AreaVolumeCalculatorState extends State<AreaVolumeCalculator> {
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _radiusController = TextEditingController();

  String _result = '';
  String _selectedShape = 'Balok';

  void _calculate() {
    final double length = double.tryParse(_lengthController.text) ?? 0;
    final double width = double.tryParse(_widthController.text) ?? 0;
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double radius = double.tryParse(_radiusController.text) ?? 0;

    setState(() {
      switch (_selectedShape) {
        case 'Balok':
          if (length > 0 && width > 0 && height > 0) {
            final double area = length * width;
            final double volume = length * width * height;
            _result =
                'Luas: ${area.toStringAsFixed(2)} m²\nVolume: ${volume.toStringAsFixed(2)} m³';
          } else {
            _result =
                'Masukkan panjang, lebar, dan tinggi yang valid untuk Balok.';
          }
          break;
        case 'Kubus':
          if (length > 0) {
            final double area = 6 * length * length;
            final double volume = length * length * length;
            _result =
                'Luas Permukaan: ${area.toStringAsFixed(2)} m²\nVolume: ${volume.toStringAsFixed(2)} m³';
          } else {
            _result = 'Masukkan panjang sisi yang valid untuk Kubus.';
          }
          break;
        case 'Silinder':
          if (radius > 0 && height > 0) {
            final double area = 2 * 3.14 * radius * (radius + height);
            final double volume = 3.14 * radius * radius * height;
            _result =
                'Luas Permukaan: ${area.toStringAsFixed(2)} m²\nVolume: ${volume.toStringAsFixed(2)} m³';
          } else {
            _result =
                'Masukkan jari-jari dan tinggi yang valid untuk Silinder.';
          }
          break;
        case 'Bola':
          if (radius > 0) {
            final double area = 4 * 3.14 * radius * radius;
            final double volume = (4 / 3) * 3.14 * radius * radius * radius;
            _result =
                'Luas Permukaan: ${area.toStringAsFixed(2)} m²\nVolume: ${volume.toStringAsFixed(2)} m³';
          } else {
            _result = 'Masukkan jari-jari yang valid untuk Bola.';
          }
          break;
        default:
          _result = 'Pilih bangunan yang ingin dihitung.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perhitungan Luas & Volume Bangunan'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    value: _selectedShape,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedShape = newValue!;
                        _result = '';
                      });
                    },
                    items: <String>['Balok', 'Kubus', 'Silinder', 'Bola']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  if (_selectedShape == 'Balok' || _selectedShape == 'Kubus')
                    _buildTextField(_lengthController, 'Panjang (m)'),
                  if (_selectedShape == 'Balok')
                    _buildTextField(_widthController, 'Lebar (m)'),
                  if (_selectedShape == 'Balok' || _selectedShape == 'Silinder')
                    _buildTextField(_heightController, 'Tinggi (m)'),
                  if (_selectedShape == 'Silinder' || _selectedShape == 'Bola')
                    _buildTextField(_radiusController, 'Jari-jari (m)'),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.color,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Hitung', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 20, color: widget.color),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

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

  // Daftar unit panjang yang tersedia
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

  // Fungsi untuk melakukan konversi panjang
  void _convertLength() {
    double input = double.tryParse(_inputController.text) ?? 0;

    if (input == 0) {
      setState(() {
        _convertedValue = 'Input tidak valid';
      });
      return;
    }

    // Menghitung konversi berdasarkan unit yang dipilih
    double convertedValue = 0;

    // Konversi dari unit sumber ke meter
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
      default: // Meter
        break;
    }

    // Konversi dari meter ke unit tujuan
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
      default: // Meter
        convertedValue = input;
        break;
    }

    setState(() {
      _convertedValue = '$convertedValue $_selectedToUnit';
    });
  }

  // Fungsi untuk menukar unit sumber dan unit tujuan
  void _swapUnits() {
    setState(() {
      String temp = _selectedFromUnit;
      _selectedFromUnit = _selectedToUnit;
      _selectedToUnit = temp;
    });
    _convertLength(); // Menghitung ulang setelah menukar unit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Panjang'),
        backgroundColor: widget.color,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field untuk panjang
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Masukkan panjang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.arrow_forward),
              ),
            ),
            SizedBox(height: 20),
            // Dropdown untuk memilih unit sumber
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: _selectedFromUnit,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFromUnit = newValue!;
                  });
                },
                items: _units.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                isExpanded: true,
                underline: SizedBox(), // Menghilangkan garis bawah default
                icon: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(height: 20),
            // Tombol untuk menukar unit sumber dan tujuan
            ElevatedButton(
              onPressed: _swapUnits,
              child: Icon(Icons.swap_horiz), // Ikon untuk menukar unit
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor:
                    Colors.green, // Menggunakan warna hijau untuk tombol swap
              ),
            ),
            SizedBox(height: 20),
            // Dropdown untuk memilih unit tujuan
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: _selectedToUnit,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedToUnit = newValue!;
                  });
                },
                items: _units.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                isExpanded: true,
                underline: SizedBox(), // Menghilangkan garis bawah default
                icon: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(height: 20),
            // Tombol untuk melakukan konversi
            ElevatedButton(
              onPressed: _convertLength,
              child: Text(
                'Konversi',
                style: TextStyle(
                  color: Colors.white, // Teks menjadi putih untuk kontras
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor:
                    widget.color, // Menggunakan warna dari parameter
                foregroundColor:
                    Colors.white, // Menetapkan warna teks menjadi putih
              ),
            ),
            SizedBox(height: 20),
            // Menampilkan hasil konversi
            Text(
              _convertedValue,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

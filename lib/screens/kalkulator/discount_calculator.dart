import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiscountCalculator extends StatefulWidget {
  final Color color;

  DiscountCalculator({required this.color});

  @override
  _DiscountCalculatorState createState() => _DiscountCalculatorState();
}

class _DiscountCalculatorState extends State<DiscountCalculator> {
  final _originalPriceController = TextEditingController();
  final _discountController = TextEditingController();
  String _result = '';

  // Formatter untuk Rupiah
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  void _calculateDiscount() {
    final double originalPrice =
        double.tryParse(_originalPriceController.text) ?? 0;
    final double discount = double.tryParse(_discountController.text) ?? 0;

    if (originalPrice > 0 && discount >= 0) {
      final double discountAmount = (discount / 100) * originalPrice;
      final double finalPrice = originalPrice - discountAmount;
      setState(() {
        _result =
            'Harga setelah diskon: ${currencyFormatter.format(finalPrice)}';
      });
    } else {
      setState(() {
        _result = 'Masukkan harga awal dan diskon yang valid';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Diskon'),
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
                        controller: _originalPriceController,
                        decoration: InputDecoration(
                          labelText: 'Harga Awal (Rp)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(Icons.monetization_on,
                              color: Colors.blueAccent),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _discountController,
                        decoration: InputDecoration(
                          labelText: 'Diskon (%)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon:
                              Icon(Icons.percent, color: Colors.blueAccent),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _calculateDiscount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.color,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text('Hitung Diskon'),
                      ),
                      SizedBox(height: 20),
                      Text(
                        _result,
                        style: TextStyle(fontSize: 20, color: widget.color),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyConverter extends StatefulWidget {
  final Color color;

  CurrencyConverter({required this.color});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final _amountController = TextEditingController();
  String _result = '';

  // Mata uang yang tersedia
  final Map<String, double> exchangeRates = {
    'USD': 1.0,
    'IDR': 15000.0,
    'EUR': 0.85,
    'JPY': 110.0,
    'GBP': 0.75,
  };

  // Mata uang yang dipilih
  String _fromCurrency = 'USD';
  String _toCurrency = 'IDR';

  // Formatter untuk mata uang
  final Map<String, NumberFormat> currencyFormats = {
    'USD': NumberFormat.currency(locale: 'en_US', symbol: '\$'),
    'IDR': NumberFormat.currency(locale: 'id_ID', symbol: 'Rp '),
    'EUR': NumberFormat.currency(locale: 'en_EU', symbol: '€'),
    'JPY': NumberFormat.currency(locale: 'ja_JP', symbol: '¥'),
    'GBP': NumberFormat.currency(locale: 'en_GB', symbol: '£'),
  };

  void _convertCurrency() {
    final double amount = double.tryParse(_amountController.text) ?? 0;

    // Hitung hasil konversi
    double fromRate = exchangeRates[_fromCurrency]!;
    double toRate = exchangeRates[_toCurrency]!;
    double convertedAmount = (amount / fromRate) * toRate;

    setState(() {
      // Format hasil konversi menggunakan `intl`
      _result =
          'Hasil: ${currencyFormats[_toCurrency]?.format(convertedAmount)}';
    });
  }

  void _swapCurrencies() {
    setState(() {
      // Tukar mata uang asal dan tujuan
      String temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _convertCurrency();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
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
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: 'Jumlah (${_fromCurrency})',
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
                          // Dropdown untuk memilih mata uang asal
                          Expanded(
                            child: DropdownButton<String>(
                              value: _fromCurrency,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _fromCurrency = newValue!;
                                  _convertCurrency();
                                });
                              },
                              items: exchangeRates.keys
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                            onPressed: _swapCurrencies,
                          ),
                          // Dropdown untuk memilih mata uang tujuan
                          Expanded(
                            child: DropdownButton<String>(
                              value: _toCurrency,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _toCurrency = newValue!;
                                  _convertCurrency();
                                });
                              },
                              items: exchangeRates.keys
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                        onPressed: _convertCurrency,
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
                        _result,
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

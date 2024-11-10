import 'package:flutter/material.dart';
import 'package:utsappbayu/widgets/menu_card.dart';
import 'area_volume_calculator.dart';
import 'calculator_screen.dart';
import 'discount_calculator.dart';

class KalkulatorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // Background utama berwarna biru
          Container(
            color: Colors.green, // Warna latar belakang utama
          ),
          // Background putih untuk konten utama
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
                children: [
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      children: [
                        MenuCard(
                          title: 'Perhitungan Luas & Volume',
                          icon: Icons.square_foot,
                          color: Colors.red,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AreaVolumeCalculator(color: Colors.red)),
                          ),
                        ),
                        MenuCard(
                          title: 'Kalkulator Umum',
                          icon: Icons.calculate,
                          color: Colors.blue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CalculatorScreen(color: Colors.blue)),
                          ),
                        ),
                        MenuCard(
                          title: 'Perhitungan Diskon',
                          icon: Icons.percent,
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DiscountCalculator(color: Colors.green)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

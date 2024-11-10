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
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
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
                    builder: (context) => CalculatorScreen(color: Colors.blue)),
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
    );
  }
}

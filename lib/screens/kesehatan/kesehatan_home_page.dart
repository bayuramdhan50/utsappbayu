import 'package:flutter/material.dart';
import 'package:utsappbayu/widgets/menu_card.dart';
import 'bmi_calculator.dart';
import 'bmr_calculator_page.dart';
import 'hydration_calculator_page.dart';
import 'tdee_calculator_page.dart';
import 'fat_percentage_calculator_page.dart';
import 'blood_pressure.dart';
import 'blood_sugar.dart';
import 'cholesterol.dart';
import 'steps_count.dart';

class KesehatanHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kesehatan'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          children: [
            MenuCard(
              title: 'BMI Calculator',
              icon: Icons.fitness_center, // Ikon yang relevan untuk BMI
              color: Colors.blueAccent, // Warna biru muda
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BMICalculator(color: Colors.blueAccent)),
              ),
            ),
            MenuCard(
              title: 'BMR Calculator',
              icon: Icons.assignment_ind, // Ikon yang relevan untuk BMR
              color: Colors.green, // Warna hijau tua
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BMRCalculatorPage(color: Colors.green)),
              ),
            ),
            MenuCard(
              title: 'Hydration Calculator',
              icon: Icons.local_drink, // Ikon air untuk hidrasi
              color: Colors.blue, // Warna biru
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HydrationCalculatorPage(color: Colors.blue)),
              ),
            ),
            MenuCard(
              title: 'TDEE Calculator',
              icon: Icons.local_fire_department, // Ikon yang relevan untuk TDEE
              color: Colors.orange, // Warna oranye
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TDEECalculatorPage(color: Colors.orange)),
              ),
            ),
            MenuCard(
              title: 'Fat Calculator',
              icon: Icons.whatshot, // Ikon yang relevan untuk Fat Calculator
              color: Colors.greenAccent, // Warna hijau cerah
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FatPercentageCalculatorPage(color: Colors.greenAccent)),
              ),
            ),
            MenuCard(
              title: 'Gula Darah',
              icon: Icons.bloodtype, // Ikon darah untuk Gula Darah
              color: Colors.red, // Warna merah muda
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BloodSugarPage(color: Colors.red)),
              ),
            ),
            MenuCard(
              title: 'Tekanan Darah',
              icon: Icons.favorite, // Ikon jantung untuk Tekanan Darah
              color: Colors.redAccent, // Warna merah tua
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BloodPressurePage(color: Colors.redAccent)),
              ),
            ),
            MenuCard(
              title: 'Kolesterol',
              icon: Icons.heart_broken, // Ikon hati untuk Kolesterol
              color: Colors.purple, // Warna ungu
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CholesterolPage(color: Colors.purple)),
              ),
            ),
            MenuCard(
              title: 'Jumlah Langkah Harian',
              icon: Icons
                  .directions_walk, // Ikon langkah untuk Jumlah Langkah Harian
              color: Colors.green, // Warna hijau muda
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StepsCountPage(color: Colors.green)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

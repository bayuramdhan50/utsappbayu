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
      body: Stack(
        children: [
          // Background color utama
          Container(
            color: Colors.purple, // Warna latar belakang utama
          ),
          // Background putih untuk konten
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
                          title: 'BMI Calculator',
                          icon: Icons.fitness_center,
                          color: Colors.blueAccent,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BMICalculator(color: Colors.blueAccent)),
                          ),
                        ),
                        MenuCard(
                          title: 'BMR Calculator',
                          icon: Icons.assignment_ind,
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BMRCalculatorPage(color: Colors.green)),
                          ),
                        ),
                        MenuCard(
                          title: 'Hydration Calculator',
                          icon: Icons.local_drink,
                          color: Colors.blue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HydrationCalculatorPage(
                                    color: Colors.blue)),
                          ),
                        ),
                        MenuCard(
                          title: 'TDEE Calculator',
                          icon: Icons.local_fire_department,
                          color: Colors.orange,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TDEECalculatorPage(color: Colors.orange)),
                          ),
                        ),
                        MenuCard(
                          title: 'Fat Calculator',
                          icon: Icons.whatshot,
                          color: Colors.greenAccent,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FatPercentageCalculatorPage(
                                        color: Colors.greenAccent)),
                          ),
                        ),
                        MenuCard(
                          title: 'Gula Darah',
                          icon: Icons.bloodtype,
                          color: Colors.red,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BloodSugarPage(color: Colors.red)),
                          ),
                        ),
                        MenuCard(
                          title: 'Tekanan Darah',
                          icon: Icons.favorite,
                          color: Colors.redAccent,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BloodPressurePage(color: Colors.redAccent)),
                          ),
                        ),
                        MenuCard(
                          title: 'Kolesterol',
                          icon: Icons.heart_broken,
                          color: Colors.purple,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CholesterolPage(color: Colors.purple)),
                          ),
                        ),
                        MenuCard(
                          title: 'Jumlah Langkah Harian',
                          icon: Icons.directions_walk,
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StepsCountPage(color: Colors.green)),
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

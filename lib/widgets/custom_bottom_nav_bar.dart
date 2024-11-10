import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:math';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  CustomBottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  // Fungsi untuk menghasilkan warna acak
  Color _generateRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // Red (0-255)
      random.nextInt(256), // Green (0-255)
      random.nextInt(256), // Blue (0-255)
      1, // Opacity (full opacity)
    );
  }

  @override
  Widget build(BuildContext context) {
    Color randomColor = _generateRandomColor(); // Generate random color

    return CurvedNavigationBar(
      index: selectedIndex, // Set the current selected index
      onTap: onItemTapped, // Function to handle tab selection
      items: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_horiz, size: 30), // Icon for Konversi
            Text('Konversi', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 30), // Icon for Kesehatan
            Text('Kesehatan', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calculate, size: 30), // Icon for Kalkulator
            Text('Kalkulator', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 30), // Icon for Akun
            Text('Akun', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
      color: Colors.white, // Background color of the nav bar
      buttonBackgroundColor:
          randomColor, // Random color for the selected button
      backgroundColor:
          randomColor.withOpacity(0.3), // Lighter random color for background
      animationCurve: Curves.easeInOut, // Animation curve when switching tabs
      animationDuration:
          Duration(milliseconds: 300), // Duration for the tab transition
    );
  }
}

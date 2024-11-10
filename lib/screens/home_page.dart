import 'package:flutter/material.dart';
import 'konversi/konversi_home_page.dart';
import '../screens/kesehatan/kesehatan_home_page.dart';
import 'kalkulator/kalkulator_home_page.dart';
import 'account_page.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Menjaga tab yang dipilih
  int _selectedIndex = 0;

  // Daftar halaman untuk dipilih sesuai dengan indeks
  final List<Widget> _pages = [
    KonversiHomePage(), // Halaman utama Konversi
    KesehatanHomePage(), // Halaman utama Kesehatan
    KalkulatorHomePage(), // Halaman utama Kalkulator
    AccountPage(), // Halaman akun
  ];

  // Fungsi untuk menangani perubahan tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _pages[_selectedIndex], // Tampilkan halaman sesuai dengan indeks tab
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex, // Indeks yang sedang dipilih
        onItemTapped: _onItemTapped, // Fungsi untuk menangani tab yang dipilih
      ),
    );
  }
}

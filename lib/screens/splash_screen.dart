import 'package:flutter/material.dart';
import 'dart:async';
import "login_page.dart";

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Timer untuk berpindah ke halaman utama setelah 5 detik
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    // Konfigurasi animasi fade-in
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Konfigurasi animasi zoom-in untuk foto profil
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang gradien yang lebih fresh (hijau & biru muda)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade200, Colors.lightBlue.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Foto dengan animasi zoom-in dan fade-in
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/fotoprofil.jpg'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Teks dengan efek fade-in
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      // Judul aplikasi dengan efek bayangan
                      Text(
                        'UTSAPPBAYU',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      // NRP dengan teks bergaya
                      Text(
                        '152022082',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 5),
                      // Nama dengan teks bergaya
                      Text(
                        'Bayu Ramdhan Ardiyanto',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                // Progress indicator dengan animasi bounce
                ScaleTransition(
                  scale: _fadeAnimation,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

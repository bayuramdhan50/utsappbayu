import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String username = '';
  String email = '';

  // Fungsi untuk mengambil data user dari SharedPreferences
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Nama pengguna tidak ditemukan';
      email = prefs.getString('email') ?? 'Email tidak ditemukan';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun Saya'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tampilkan informasi akun
            Text(
              'Selamat datang, $username!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Tombol logout
            ElevatedButton(
              onPressed: () {
                // Logika logout, bisa menggunakan Navigator.push untuk kembali ke halaman login
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Warna tombol
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

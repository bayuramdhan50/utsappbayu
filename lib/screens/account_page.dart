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
      body: Container(
        color: Colors
            .blueAccent, // Background warna biru untuk keseluruhan halaman
        child: Stack(
          children: [
            // Konten utama dengan background putih
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white, // Background putih untuk konten utama
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
                width: double.infinity, // Membuat lebar container penuh
                height: double.infinity, // Membuat tinggi container penuh
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Tengah-tengah secara vertikal
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Menampilkan informasi akun
                      Text(
                        'Selamat datang, $username!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign:
                            TextAlign.center, // Menyelaraskan teks di tengah
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Email: $email',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                        textAlign:
                            TextAlign.center, // Menyelaraskan teks di tengah
                      ),
                      SizedBox(height: 40),
                      // Tombol logout dengan desain yang lebih menarik
                      ElevatedButton(
                        onPressed: () async {
                          // Menghapus data user dari SharedPreferences
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('username');
                          prefs.remove('email');

                          // Kembali ke halaman login setelah logout
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent, // Warna tombol
                          foregroundColor: Colors.white, // Warna teks tombol
                          padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 50), // Menambahkan padding
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold), // Ukuran dan berat teks
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Memberikan sudut melengkung
                          ),
                          elevation: 5, // Menambahkan efek bayangan
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

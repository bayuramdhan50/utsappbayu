import 'package:flutter/material.dart';
import 'package:utsappbayu/widgets/menu_card.dart';
import 'currency_converter.dart';
import 'temperature_converter.dart';
import 'length_converter.dart';
import 'internet_speed_converter.dart';
import 'volume_conversion.dart';
import 'speed_conversion.dart';
import 'time_conversion.dart';
import 'energy_conversion.dart';

class KonversiHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blueAccent, // Warna latar belakang utama
          ),
          // Membuat background putih full layar
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
                          title: 'Konversi Mata Uang',
                          icon: Icons.attach_money,
                          color: Colors.teal,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CurrencyConverter(color: Colors.teal),
                            ),
                          ),
                        ),
                        MenuCard(
                          title: 'Konversi Suhu',
                          icon: Icons.thermostat,
                          color: Colors.orange,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TemperatureConverter(color: Colors.orange),
                            ),
                          ),
                        ),
                        MenuCard(
                          title: 'Konversi Panjang',
                          icon: Icons.straighten,
                          color: Colors.indigo,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LengthConversionPage(color: Colors.indigo),
                            ),
                          ),
                        ),
                        MenuCard(
                          title: 'Konversi Kecepatan',
                          icon: Icons.speed,
                          color: Colors.red,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InternetSpeedConverter(color: Colors.red),
                            ),
                          ),
                        ),
                        MenuCard(
                          title: 'Konversi Volume',
                          icon: Icons.local_drink,
                          color: Colors.green,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VolumeConversionPage(color: Colors.green),
                            ),
                          ),
                        ),
                        MenuCard(
                          title: 'Konversi Speed Kendaraan',
                          icon: Icons.drive_eta,
                          color: Colors.purple,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SpeedConversionPage(color: Colors.purple),
                            ),
                          ),
                        ),
                        MenuCard(
                          title: 'Konversi Waktu',
                          icon: Icons.access_alarm,
                          color: Colors.blue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TimeConversionPage(color: Colors.blue),
                            ),
                          ),
                        ),
                        MenuCard(
                          title: 'Konversi Energi',
                          icon: Icons.flash_on,
                          color: Colors.yellow,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EnergyConversionPage(color: Colors.yellow),
                            ),
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

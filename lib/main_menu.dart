import 'package:flutter/material.dart';
import 'package:kuistpm_123220133/login_page.dart';
import 'package:kuistpm_123220133/bangun1.dart';
import 'package:kuistpm_123220133/bangun2.dart';
import 'package:kuistpm_123220133/hitung_hari.dart';
import 'package:kuistpm_123220133/data_diri.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 300,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 5, // 3 menu utama + 1 tombol logout
            itemBuilder: (context, index) {
              final items = [
                {'title': 'Hitung Jajar Genjang', 'icon': Icons.add_to_queue, 'page': JajarGenjangScreen()},
                {'title': 'Hitung Limas', 'icon': Icons.text_rotation_angledown ,'page': LimasScreen()},
                {'title': 'Hitung Hari', 'icon': Icons.date_range, 'page': HitungHariScreen()},
                {'title': 'Data Diri', 'icon': Icons.person, 'page': DataScreen()},
              ];

              if (index == 4) {
                return _buildLogoutCard(context);
              } else {
                return _buildCard(
                  context,
                  items[index]['title'] as String,
                  items[index]['icon'] as IconData,
                  items[index]['page'] as Widget,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil Logout!'),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 2),
          ),
        );

        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        });
      },
      child: Card(
        color: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.exit_to_app, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Logout',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

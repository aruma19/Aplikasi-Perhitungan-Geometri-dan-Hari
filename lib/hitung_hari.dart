import 'package:flutter/material.dart';

class HitungHariScreen extends StatefulWidget {
  @override
  _HitungHariScreenState createState() => _HitungHariScreenState();
}

class _HitungHariScreenState extends State<HitungHariScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _hitungHari() {
    int? number = int.tryParse(_controller.text);
    if (number == null || number < 1 || number > 7) {
      setState(() {
        _result = "Masukkan angka antara 1 hingga 7!";
      });
      return;
    }

    List<String> hari = [
      "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"
    ];

    setState(() {
      _result = "Hari ke-$number adalah ${hari[number - 1]}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Penghitung Hari",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Masukkan angka (1-7) untuk mengetahui hari:",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Masukkan angka 1-7",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _hitungHari,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: Text("Cek Hari", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              Text(
                _result,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

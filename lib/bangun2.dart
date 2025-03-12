import 'package:flutter/material.dart';

class LimasScreen extends StatefulWidget {
  @override
  _LimasScreenState createState() => _LimasScreenState();
}

class _LimasScreenState extends State<LimasScreen> {
  final TextEditingController panjangController = TextEditingController();
  final TextEditingController lebarController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();

  String? selectedCalculation;
  double result = 0.0;

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  bool isValidNumber(String value) {
    final regex = RegExp(r'^\d+(\.\d+)?$');
    return regex.hasMatch(value);
  }

  void calculate() {
    String panjangText = panjangController.text.trim();
    String lebarText = lebarController.text.trim();
    String tinggiText = tinggiController.text.trim();

    if (selectedCalculation == null) {
      showError("Silakan pilih perhitungan Volume atau Keliling.");
      return;
    }

    if (panjangText.isEmpty || lebarText.isEmpty) {
      showError("Panjang dan lebar alas tidak boleh kosong.");
      return;
    }
    if (!isValidNumber(panjangText) || !isValidNumber(lebarText)) {
      showError("Panjang atau lebar alas harus berupa angka yang valid.");
      return;
    }

    double panjang = double.parse(panjangText);
    double lebar = double.parse(lebarText);
    double tinggi = selectedCalculation == "Volume" && isValidNumber(tinggiText) ? double.parse(tinggiText) : 0;

    if (selectedCalculation == "Volume" && tinggiText.isEmpty) {
      showError("Tinggi limas tidak boleh kosong.");
      return;
    }

    if (selectedCalculation == "Volume") {
      result = (1 / 3) * (panjang * lebar) * tinggi;
    } else if (selectedCalculation == "Keliling") {
      if (panjang == lebar) {
        result = 4 * panjang; // Keliling jika alas adalah persegi
      } else {
        result = 2 * (panjang + lebar); // Keliling jika alas adalah persegi panjang
      }
    }

    setState(() {});
  }

  Widget buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hitung Limas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => selectedCalculation = "Volume"),
                  child: Text("Volume"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCalculation == "Volume" ? Colors.blueAccent : Colors.grey[300],
                    foregroundColor: selectedCalculation == "Volume" ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => setState(() => selectedCalculation = "Keliling"),
                  child: Text("Keliling"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCalculation == "Keliling" ? Colors.blueAccent : Colors.grey[300],
                    foregroundColor: selectedCalculation == "Keliling" ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (selectedCalculation != null) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      buildInputField("Panjang Alas", panjangController),
                      buildInputField("Lebar Alas", lebarController),
                      if (selectedCalculation == "Volume") buildInputField("Tinggi Limas", tinggiController),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: calculate,
                        child: Text("Hitung"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (result > 0)
              Card(
                elevation: 5,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text("Hasil Perhitungan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      Text("$result", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.yellowAccent)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
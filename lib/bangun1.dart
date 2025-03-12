import 'package:flutter/material.dart';
import 'dart:core';

class JajarGenjangScreen extends StatefulWidget {
  @override
  _JajarGenjangScreenState createState() => _JajarGenjangScreenState();
}

class _JajarGenjangScreenState extends State<JajarGenjangScreen> {
  final TextEditingController alasController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();
  final TextEditingController sisiMiringController = TextEditingController();

  String? selectedCalculation;
  double result = 0.0;

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  bool isValidNumber(String value) {
    final regex = RegExp(r'^\d+(\.\d+)?$'); 
    return regex.hasMatch(value);
  }

  void calculate() {
    String alasText = alasController.text.trim();
    String tinggiText = tinggiController.text.trim();
    String sisiMiringText = sisiMiringController.text.trim();

    if (selectedCalculation == null) {
      showError("Silakan pilih perhitungan Luas atau Keliling.");
      return;
    }

    if (alasText.isEmpty) {
      showError("Inputan alas masih kosong. Harap isi dengan angka.");
      return;
    }
    if (!isValidNumber(alasText)) {
      showError("Inputan alas tidak valid. Harap masukkan angka yang benar.");
      return;
    }

    if (selectedCalculation == "Luas") {
      if (tinggiText.isEmpty) {
        showError("Inputan tinggi masih kosong. Harap isi dengan angka.");
        return;
      }
      if (!isValidNumber(tinggiText)) {
        showError("Inputan tinggi tidak valid. Harap masukkan angka yang benar.");
        return;
      }
    }

    if (selectedCalculation == "Keliling") {
      if (sisiMiringText.isEmpty) {
        showError("Inputan sisi miring masih kosong. Harap isi dengan angka.");
        return;
      }
      if (!isValidNumber(sisiMiringText)) {
        showError("Inputan sisi miring tidak valid. Harap masukkan angka yang benar.");
        return;
      }
    }

    // Parsing angka setelah validasi berhasil
    double alas = double.parse(alasText);
    double tinggi = selectedCalculation == "Luas" ? double.parse(tinggiText) : 0;
    double sisiMiring = selectedCalculation == "Keliling" ? double.parse(sisiMiringText) : 0;

    // Perhitungan berdasarkan pilihan
    if (selectedCalculation == "Luas") {
      result = alas * tinggi;
    } else if (selectedCalculation == "Keliling") {
      result = 2 * (alas + sisiMiring);
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
        title: Text("Hitung Jajar Genjang",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      selectedCalculation = "Luas";
                    });
                  },
                  icon: Icon(Icons.area_chart),
                  label: Text("Luas"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCalculation == "Luas"
                        ? Colors.blueAccent
                        : Colors.grey[300],
                    foregroundColor:
                        selectedCalculation == "Luas" ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      selectedCalculation = "Keliling";
                    });
                  },
                  icon: Icon(Icons.border_outer),
                  label: Text("Keliling"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCalculation == "Keliling"
                        ? Colors.blueAccent
                        : Colors.grey[300],
                    foregroundColor:
                        selectedCalculation == "Keliling" ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (selectedCalculation != null) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Masukkan Nilai",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      buildInputField("Alas", alasController),
                      if (selectedCalculation == "Luas")
                        buildInputField("Tinggi", tinggiController),
                      if (selectedCalculation == "Keliling")
                        buildInputField("Sisi Miring", sisiMiringController),
                      SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: calculate,
                          child: Text("Hitung"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (result != null)
              Card(
                elevation: 5,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Hasil Perhitungan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "$result",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellowAccent,
                        ),
                      ),
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

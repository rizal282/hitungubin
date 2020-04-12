// aplikasi sederhana
// cara menghitung ubin yang akan digunakan disebuah ruangan


// semoga bermanfaat :)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hitung Penggunaan Ubin",
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: HomeHitungUbin(),
    );
  }
}

class HomeHitungUbin extends StatefulWidget {
  @override
  _HomeHitungUbinState createState() => _HomeHitungUbinState();
}

class _HomeHitungUbinState extends State<HomeHitungUbin> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static const platform = MethodChannel("hitungTotalUbin");

  // untuk menangkap data yang diinput oleh user dari textformfield
  TextEditingController panjangRuangan = new TextEditingController();
  TextEditingController lebarRuangan = new TextEditingController();
  TextEditingController panjangUbin = new TextEditingController();
  TextEditingController lebarUbin = new TextEditingController();

  void _hitungTotalUbin() async {
    if(formKey.currentState.validate()){

      // setiap data yang diinput dari textformfield oleh user akan bertipe string
      // ubah tipe data yang diinputkan user ke integer 

      // pada contoh ini menggunakan tipe integer

      int pR = int.parse(panjangRuangan.text);
      int lR = int.parse(lebarRuangan.text);
      int pU = int.parse(panjangUbin.text);
      int lU = int.parse(lebarUbin.text);


      // kirim data yang diinput ke method channel
      // dan akan diproses di file mainactivity.java
      final int totalUbinPakai = await platform.invokeMethod("totalUbin", {"pRuang":pR, "lRuang":lR, "pUbin":pU, "lUbin":lU});


      // hasilnya akan ditampilkan di console log vscode
      print("Panjang Ruangan : $pR");
      print("Lebar Ruangan : $lR");
      print("Panjang Ubin : $pU");
      print("Lebar Ubin : $lU");

      print("Ubin Yang digunakan adalah : $totalUbinPakai");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hitung Penggunaan Ubin", style: TextStyle(fontWeight: FontWeight.w300),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: formElement(),
          ),
        ),
      ),
    );
  }

  Widget formElement() {
    return Column(
      children: <Widget>[
        Text("Luas Ruangan", style: TextStyle(fontSize: 18),),

        SizedBox(height: 20,),

        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Panjang Ruangan",
            hintText: "Masukan Panjang Ruangan",
            border: OutlineInputBorder()
          ),
          validator: (String value){
            if(value.isEmpty){
              return "Panjang Ruangan Masih Kosong";
            }

            return null;
          },
          controller: panjangRuangan,
        ),

        SizedBox(height: 20,),

        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Lebar Ruangan",
              hintText: "Masukan Lebar Ruangan",
              border: OutlineInputBorder()
          ),
          validator: (String value){
            if(value.isEmpty){
              return "Lebar Ruangan Masih Kosong";
            }

            return null;
          },
          controller: lebarRuangan,
        ),
        new Divider(),

        SizedBox(height: 20,),

        Text("Luas Ubin", style: TextStyle(fontSize: 18),),

        SizedBox(height: 20,),

        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Panjang Ubin",
              hintText: "Masukan Panjang Ubin",
              border: OutlineInputBorder()
          ),
          validator: (String value){
            if(value.isEmpty){
              return "Panjang Ubin Masih Kosong";
            }

            return null;
          },
          controller: panjangUbin,
        ),

        SizedBox(height: 20,),

        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Lebar Ubin",
              hintText: "Masukan Lebar Ubin",
              border: OutlineInputBorder()
          ),
          validator: (String value){
            if(value.isEmpty){
              return "Lebar Ubin Masih Kosong";
            }

            return null;
          },
          controller: lebarUbin,
        ),
        new Divider(),

        Card(
          color: Colors.black,
          elevation: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: InkWell(
              splashColor: Colors.white,
              child: Center(
                child: Text("Hitung", style: TextStyle(color: Colors.white),),
              ),
              onTap: (){
                _hitungTotalUbin();
              },
            ),
          ),
        )
      ],
    );
  }
}


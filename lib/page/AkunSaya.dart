import 'package:card_swiper/card_swiper.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/etc/genDimen.dart';
import '../genosLib/component/etc/genRow.dart';
import '../genosLib/component/etc/genShadow.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/component/textfiled/TextField.dart';
import '../genosLib/genColor.dart';
import '../genosLib/genText.dart';
import '../genosLib/request.dart';
import 'menuNavbar.dart';

class AkunSaya extends StatefulWidget {
  const AkunSaya({Key? key}) : super(key: key);

  @override
  State<AkunSaya> createState() => _AkunSayaState();
}

class _AkunSayaState extends State<AkunSaya> {

  var dataProfil;
  var req = new GenRequest();

  int _currentIndex = 0;
  var nama = "";
  var alamat = "";
  var no_hp = "";

  @override
  void initState() {
    // TODO: implement initState
    getProfile();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GenPage(
      body: Container(
        padding: EdgeInsets.all(30),
        width: double.infinity,
        child: nama == ""
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "PROFIL",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Image.network("https://cdn-icons-png.flaticon.com/128/3135/3135715.png"),
              SizedBox(
                height: 20,
              ),
              TextLoginField(
                initVal: nama,
                width: double.infinity,
                label: "Nama",
                keyboardType: TextInputType.name,
//                                    controller: tecNumber,
                onChanged: (val) {
                  nama = val;
                },
                validator: (val) {
                  if (val.length < 1) {
                    return "Isi Nama Dengan Benar";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextLoginField(
                initVal: alamat,
                width: double.infinity,
                label: "Alamat",
                keyboardType: TextInputType.streetAddress,
//                                    controller: tecNumber,
                onChanged: (val) {
                  alamat = val;
                },
                validator: (val) {
                  if (val.length < 1) {
                    return "Isi Alamat Dengan Benar";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextLoginField(
                initVal: no_hp,
                width: double.infinity,
                label: "No. HP",
                keyboardType: TextInputType.number,
//                                    controller: tecNumber,
                onChanged: (val) {
                  no_hp = val;
                },
                validator: (val) {
                  if (val.length < 1) {
                    return "Isi No HP";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),

              Divider(),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 30,
              ),

              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      ),
    );
  }

  void getProfile() async {
    dataProfil = await req.getApi("profile");
    print("DATA $dataProfil");


    nama = dataProfil["klinik"]["nama_klinik"];
    alamat = dataProfil["klinik"]["alamat"];
    no_hp = dataProfil["klinik"]["no_hp"];

    setState(() {});
  }
}

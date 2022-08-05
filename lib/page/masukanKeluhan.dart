
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../genosLib/component/button/genButton.dart';
import '../genosLib/component/commonPadding.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/component/textfiled/TextField.dart';
import '../genosLib/genText.dart';
import '../genosLib/genToast.dart';
import '../genosLib/request.dart';

class MasukanKeluhan extends StatefulWidget {
  const MasukanKeluhan({Key? key}) : super(key: key);

  @override
  State<MasukanKeluhan> createState() => _MasukanKeluhanState();
}

class _MasukanKeluhanState extends State<MasukanKeluhan> {

  XFile? _image;
  final _picker = ImagePicker();

  var readyToHit = true;

  Future<XFile?> pickImage() async {
    final _picker = ImagePicker();

    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print('PickedFile: ${pickedFile.toString()}');
      setState(() {
        _image = XFile(pickedFile.path); // Exception occurred here
      });
    } else {
      print('PickedFile: is null');
    }

    if (_image != null) {
      return _image!;
    }
    return null;
  }

  Future<void> getLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      // for (final XFile file in response.files) {
      //   // _handleFile(file);
      // }
    } else {
      // _handleError(response.exception);
    }
  }


  final req = new GenRequest();
  var dataKeluhan, deskripsi;
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return GenPage(
      appbar: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        child: Center(
                            child: Icon(
                          Icons.chevron_left,
                          size: 30,
                        ))),
                  ),
                  Container(
                      // height: 80,
                      child: InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                          },
                          child: GenText(
                            "Masukan Keluhan",
                            style: TextStyle(fontSize: 20),
                          ))),
                  // GenText(
                  //   "QR Code",
                  //   style: TextStyle(color: Colors.black87, fontSize: 35),
                  // )
                ]),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonPadding(
                      child: Row(
                        children: [
                          FloatingActionButton(
                            mini: true,
                            child: Icon(Icons.camera_alt),
                            onPressed: () {
                              pickImage();
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GenText(
                            "Masukan Foto Keluhan",
                            style: TextStyle(color: Colors.black45),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _image == null
                        ? Container(
                      width: 0,
                      height: 0,
                    )
                        : Image.file(
                      File(_image!.path),
                      width: 150,
                      fit: BoxFit.fitWidth,
                    ),
                    CommonPadding(
                      child: TextLoginField(
                        onChanged: (val){ deskripsi = val;},
                        label: "Keterangan",
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [



                  !readyToHit ? Center(child: CircularProgressIndicator(),) :  GenButton(
                    text: "Submit",
                    ontap: () {
                      MasukanKeluhan(_image);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  void MasukanKeluhan(gambar1) async {

    setState(() {
      readyToHit = false;
    });

    String fileName = gambar1.path.split('/').last;

    if(deskripsi != null){
      dataKeluhan = await req
          .postApiAuth("keluhan",
          {
            "gambar": await MultipartFile.fromFile(gambar1.path, filename: fileName),
            "deskripsi": deskripsi,
          });

      print(dataKeluhan);

      if(dataKeluhan["status"] == 200){
        toastShow("Keluhan berhasil di upload", context, Colors.black);
        Navigator.popAndPushNamed(context, "home");
      }else{
        toastShow("Username / Password salah", context, Colors.black);
      }




      // Navigator.popAndPushNamed(context, "home");
    }else{
      setState(() {
        readyToHit = true;
      });
      toastShow("Deskripsi belum diisi", context, Colors.black);
    }

    print("DATA $dataKeluhan");
    print("length" + dataKeluhan.length.toString());
  }

}
